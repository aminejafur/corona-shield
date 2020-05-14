import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
import 'package:mcovidshield/model/colistiondata.dart';
import 'package:mcovidshield/util/database_helper.dart';
import 'package:mcovidshield/util/encryption.dart';
import 'package:mcovidshield/util/style.dart';

class Discover extends StatefulWidget {
  @override
  DiscoverState createState() {
    return new DiscoverState();
  }
}

class DiscoverState extends State<Discover> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  bool _scanning = false;
  bool _forceStop = false;
  String _dataText = '';
  List<List> _data = [];
  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.3,
      duration: Duration(seconds: 3),
    )..reset();

    _bluetooth.devices.listen((device) {
      setState(() {
        _data.add([device.name,device.address]);
        _dataText += device.name+' (${device.address})\n';
        db.saveCollision(
        new Collision(1 ,
            encryptMcovidShield(device.name) ,
            encryptMcovidShield(DateTime(DateTime.now().year,
                       DateTime.now().month,
                       DateTime.now().day,
                       DateTime.now().hour,
                       DateTime.now().minute).toString()),
            //just a bad tric :v, can't encrypt this for sql grouping!
            device.address.replaceAll(':', '/-'))
        ).then((_) async {
          print('new personne ' + _data.toString());
        });
      });
    });
    _bluetooth.scanStopped.listen((device) {
      setState(() {
        //turn true for limitless listening, check _forceStop to turn in to false
         _scanning = true;
         if(!_scanning){
           _dataText += 'scan stopped\n';
         }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [MyColors.red, MyColors.primary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyColors.red, MyColors.primary],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildCircularContainer(200),
            _buildCircularContainer(250),
            _buildCircularContainer(300),
            Align(child: Container(
              foregroundDecoration: BoxDecoration(
                color:  _scanning ?  Colors.transparent : Colors.grey,
                backgroundBlendMode: BlendMode.saturation,
                shape: BoxShape.circle,
              ),
              child: RawMaterialButton(
                onPressed: () async{
                  print(_data.toString());
                  try {
                    if(_scanning) {
                      _controller.reset();
                      await _bluetooth.stopScan();
                      debugPrint("scanning stoped");
                      setState(() {
                        _scanning = false;
                        _forceStop = true;
                       });
                    }
                    else {
                      await _bluetooth.startScan(pairedDevices: false);
                      _controller.repeat();
                      debugPrint("scanning started");
                      setState(() {
                        _scanning = true;
                        _forceStop = false;
                      });
                    }
                  } on PlatformException catch (e) {
                    debugPrint(e.toString());
                  }
                  print('_scanning  = ' + _scanning.toString());
                },
                elevation: 2.0,
                fillColor: Colors.white,
                child: Icon(
                  _scanning ? Icons.wifi_tethering : Icons.portable_wifi_off,
                  size: 85.0,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
            )),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment(0,-0.8),
                  child: Text(
                    "M-Covid Shield!\n We found ${_data.length} persones!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.87),
                      fontWeight: FontWeight.w200,
                      fontSize: 28.0,
                    ),
                  ),
                ),
//                Text(_dataText)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularContainer(double radius) {
    return AnimatedBuilder(
      animation: CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      builder: (context, child) {
        return Container(
          width: _controller.value * radius,
          height: _controller.value * radius,
          decoration: BoxDecoration(color: Colors.black54.withOpacity(1 - _controller.value), shape: BoxShape.circle),
        );
      },
    );
  }
}