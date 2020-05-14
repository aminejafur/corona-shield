import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcovidshield/model/tracker.dart';
import 'package:mcovidshield/ui/showAllData.dart';
import 'package:mcovidshield/widgets/custom_text_field.dart';
import 'package:mcovidshield/util/database_helper.dart';
import 'package:mcovidshield/util/encryption.dart';
import 'package:mcovidshield/util/globalVars.dart';
import 'package:mcovidshield/util/api_helper.dart';
import 'package:mcovidshield/util/screen_navigation.dart';
import 'package:mcovidshield/util/style.dart';

showComingsoon(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text("This page will be available in next updates.",style: TextStyle(fontWeight: FontWeight.w300),),
        actions: [
          FlatButton(
            child: Text("OK",style: TextStyle(color: MyColors.primary),),
            onPressed: () { Navigator.of(context).pop(); },
          ),
        ],
      );
    },
  );
}

showAllData(BuildContext context) {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController password = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 150,
          child: Column(
            children: <Widget>[
              Text("Please enter the password to show data, ( The password is only known by the government )",style: TextStyle(fontWeight: FontWeight.w300),textAlign: TextAlign.justify,),
              SizedBox(height: 20,),
              CustomTextField(type: TextInputType.visiblePassword,icon: Icons.lock_outline,hintText: 'Password',controller: password,padding: false,)
            ],
          ),
        ),
        actions: [
          FlatButton(
            child: Text("Go",style: TextStyle(color: MyColors.primary),),
            onPressed: () {
             if(password.text == MyVars.govPassword){
                print('password is correct');
                pushScreen(context, allCollision());
              }else{
                Navigator.of(context).pop();
              }
            },
          ),
          FlatButton(
            child: Text("Cancel",style: TextStyle(color: MyColors.primary),),
            onPressed: () { Navigator.of(context).pop(); },
          ),
        ],
      );
    },
  );
}

ApiRequestsHelper api = new ApiRequestsHelper();

uploadAllData(BuildContext context, List collisions, Tracker tracker) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 140,
          child: Column(
            children: <Widget>[
              Text("Are you sure you want to upload this data?",style: TextStyle(fontWeight: FontWeight.w300),textAlign: TextAlign.justify,),
              SizedBox(height: 20,),
             ],
          ),
        ),
        actions: [
          FlatButton(
            child: Text("Upload",style: TextStyle(color: MyColors.primary),),
            onPressed: () {
              print('Process upload');
              for( final collision in collisions){
               // print(collision['mac'].toString().replaceAll('/-', ':') + ' - ' + decryptMcovidShield(collision['deviceName'].toString()) + ' - ' + decryptMcovidShield(collision['dateCollision'].toString()) + ' - ' + decryptMcovidShield(tracker.cin));
               api.uploadCollisions(decryptMcovidShield(collision['deviceName'].toString()),decryptMcovidShield(collision['dateCollision'].toString()),collision['mac'].toString().replaceAll('/-', ':'),decryptMcovidShield(tracker.mac).replaceAll('/-', ':')).whenComplete(() {
                 if (api.status) {
                   print("${api.status} : ++/${collisions.length}");
                 }
               });
              }
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("Cancel",style: TextStyle(color: MyColors.primary),),
            onPressed: () { Navigator.of(context).pop(); },
          ),
        ],
      );
    },
  );
}

exitModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 50,
          child: Column(
            children: <Widget>[
              Text("Are you sure you want Exit?",style: TextStyle(fontWeight: FontWeight.w300),textAlign: TextAlign.justify,),
              SizedBox(height: 20,),
            ],
          ),
        ),
        actions: [
          FlatButton(
            child: Text("Yes",style: TextStyle(color: MyColors.primary),),
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
          FlatButton(
            child: Text("Cancel",style: TextStyle(color: MyColors.primary),),
            onPressed: () { Navigator.of(context).pop(); },
          ),
        ],
      );
    },
  );
}
