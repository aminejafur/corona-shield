import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';

class BlueToothProvider with ChangeNotifier{
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool isOn;
  String _data = 'Nobody found yet!';
  bool _scanning = false;
  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();

  String get data => _data;

  BlueToothProvider.initialize(){
    turnOn();
  }

  void turnOn()async{
    isOn = await flutterBlue.isOn;
    notifyListeners();
  }

  Future<void> searchForDevices()async{
    isOn = await flutterBlue.isOn;
    notifyListeners();
    if(!isOn){
      return;
    }else{
      await _bluetooth.startScan(pairedDevices: false);

      _bluetooth.devices.toList().then((v){
        print("number of devices: ${ v.length}");
      });
      _bluetooth.devices.listen((device) {
        if(device != null){
          _data = "";
        }
        _data += device.name+' (${device.address})\n';
        notifyListeners();
      });
    }
  }
}