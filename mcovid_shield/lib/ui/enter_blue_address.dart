import 'package:mcovidshield/model/tracker.dart';
import 'package:mcovidshield/ui/home.dart';
import 'package:mcovidshield/widgets/custom_text_field.dart';
import 'package:mcovidshield/util/encryption.dart';
import 'package:mcovidshield/util/api_helper.dart';
import 'package:mcovidshield/util/screen_navigation.dart';
import 'package:mcovidshield/util/style.dart';
import 'package:mcovidshield/widgets/custom_button.dart';
import 'package:mcovidshield/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mcovidshield/util/database_helper.dart';

class BluetoothAddress extends StatefulWidget {
  final Tracker tracker;
  BluetoothAddress(this.tracker);

  @override
  _BluetoothAddressState createState() => _BluetoothAddressState();
}

class _BluetoothAddressState extends State<BluetoothAddress> {
  TextEditingController mac = TextEditingController();
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  String _address = "nothing";
  DatabaseHelper db = new DatabaseHelper();
  ApiRequestsHelper api = new ApiRequestsHelper();
  var errorMessage = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
     // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if (await FlutterBluetoothSerial.instance.isEnabled) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address;
          mac.text = (_address != "nothing") ? _address : "Try activating your bleutooth";
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    print('_address -> ' + widget.tracker.toString());
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: MyColors.primary,
            ),
            clipper: CustomClipPath(),
          ),
          SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/bleutooth.png",
                    width: 160,
                  ),
                ],
              ),
              SizedBox(height: 10),
              CustomText(text: "MAC ADRESSE!", size: 28, weight: FontWeight.bold),
              SizedBox(height: 5),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                  (_address == "nothing")
                      ?
                  RichText(
                       text:  TextSpan(children: [
                              TextSpan(text: "Please activate your"),
                              TextSpan(text: " Bluetooth ", style: TextStyle(color: MyColors.red)),
                              TextSpan(text: "so we can get your mac adresse for you, else you find it following these steps:"),
                              /* check if android or ios and provide the path to the mac adresse*/
                              ], style: TextStyle(color: MyColors.black)))
                  :
                  Text("We are going to share your mac adresse too, please validate this step.", textAlign: TextAlign.center, style: TextStyle(color: MyColors.grey),)
              ),
              CustomText(text: errorMessage, color: MyColors.red,),
              SizedBox(height: 10),
              CustomTextField(controller: mac,hintText: 'MAC ADRESSE',icon: Icons.bluetooth_audio,type: TextInputType.text,enabled:(_address == "nothing") ? true : false),
              SizedBox(height: 10),
              (!loading)
              ?
              CustomButton(msg: "Send Address", onTap: (){
                print('mac -->' + mac.text);
                if(mac.text.trim().length == 0){
                  setState(() {
                    errorMessage = "Please fill the MAC Adresse";
                  });
                }else{
                  RegExp regExp = new RegExp(
                    r"^[a-fA-F0-9:]{17}|[a-fA-F0-9]{12}$",
                    caseSensitive: false,
                    multiLine: false,
                  );
                  if(regExp.hasMatch(mac.text)){
                    setState(() {
                      loading = true;
                    });
                    api.registerUser(widget.tracker.cin,widget.tracker.phone,mac.text).whenComplete(() {
                      print(' status is '  + api.status.toString());
                      if (!api.status) {
                        setState(() {
                          loading = false;
                          errorMessage =
                          "Please check your internet, or try again later.";
                        });
                      } else {
                        db.updateTracker(Tracker.fromMap({
                          'id': widget.tracker.id,
                          'phone': encryptMcovidShield(widget.tracker.phone),
                          'cin': encryptMcovidShield(widget.tracker.cin),
                          'mac': encryptMcovidShield(mac.text),
                          'collisions': null,
                          'moreinfo': null
                        })).then((_) async{
                          var tracker = await db.getTracker(1);
                          /*print('DEBUG ' + tracker.id.toString() + ' - '+ tracker.phone.toString() + ' - '+ tracker.mac.toString());*/
                          replaceScreen(context, Home(tracker));
                        });
                      }
                    });
                  }else{
                    setState(() {
                      errorMessage = "Please fill a valid MAC Adresse";
                    });
                    print('bad regex');
                  }
                }
              })
              :
              CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(MyColors.red),
              ),
              SizedBox(height: 10),
            ]),
          ),
        ],
      )
    );
  }
}