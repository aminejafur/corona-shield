import 'package:mcovidshield/model/tracker.dart';
import 'package:mcovidshield/ui/enter_blue_address.dart';
import 'package:mcovidshield/widgets/custom_text_field.dart';
import 'package:mcovidshield/util/screen_navigation.dart';
import 'package:mcovidshield/util/style.dart';
import 'package:mcovidshield/widgets/custom_button.dart';
import 'package:mcovidshield/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:mcovidshield/util/database_helper.dart';

class Singup extends StatefulWidget {
  final Tracker tracker;
  Singup(this.tracker);

  @override
  _SingupState createState() => _SingupState();
}

class _SingupState extends State<Singup> {

  TextEditingController number = TextEditingController();
  TextEditingController cin = TextEditingController();
  DatabaseHelper db = new DatabaseHelper();
  var errorMessage = 0;
  @override
  Widget build(BuildContext context) {
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
                 height: 30,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Image.asset(
                     "assets/images/Flag.png",
                     width: 300,
                   ),
                 ],
               ),
               SizedBox(height: 10),
               /* CustomText(text: "M-Covid Shield", size: 28, weight: FontWeight.bold,color: MyColors.red,),*/
               SizedBox(height: 5),
               RichText(
                   text: TextSpan(children: [
                     TextSpan(text: "M-Covid", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: MyColors.primary)),
                     TextSpan(text:" SHIELD", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: MyColors.red) ),
                     TextSpan(text: " APP", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: MyColors.primary)),
                   ], style: TextStyle(color: MyColors.black))),
               SizedBox(height: 10),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam id eleifend nisl. Integer diam justo, tincidunt convallis velit nec", textAlign: TextAlign.center, style: TextStyle(color: MyColors.grey),),
               ),
               SizedBox(height: 10),
               CustomText(text: (errorMessage != 0) ?  ' ${errorMessage.toString()} Please fill all infos' : '', color: MyColors.red,),
               SizedBox(height: 10),
               CustomTextField(controller: number,hintText: '+121 612654589',icon: Icons.phone,type: TextInputType.number,),
               CustomTextField(controller: cin,hintText: 'CIN',icon: Icons.perm_identity,type: TextInputType.text,),
               SizedBox(height: 5),
               SizedBox(height: 10),
               CustomButton(msg: "Create my account", onTap: () {
                 if(number.text.trim().length == 0 || cin.text.trim().length == 0 ){
                   setState(() {
                     errorMessage += 1;
                   });
                 }else{
                  if(widget.tracker != null){
                     db.updateTracker(Tracker.fromMap({
                       'id': widget.tracker.id,
                       'phone': number.text,
                       'cin': cin.text
                     })).then((_) async {
                       var tracker = await db.getTracker(1);
    /*print('DEBUG ' + tracker.id.toString() + ' - '+ tracker.phone.toString() + ' - '+ tracker.mac.toString());*/
                       replaceScreen(context, BluetoothAddress(tracker));
                     });
                   }else{
                     db.saveTracker(Tracker.fromMap({
                       'phone': number.text,
                       'cin': cin.text
                     })).then((_) async {
                       var tracker = await db.getTracker(1);
    /*print('DEBUG ' + tracker.id.toString() + ' - '+ tracker.phone.toString() + ' - '+ tracker.mac.toString());*/
                       replaceScreen(context, BluetoothAddress(tracker));
                     });
                   }
                 }
               })
             ]),
           ),
         ],
      ),
    );
  }
}
