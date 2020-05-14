import 'package:flutter/material.dart';
import 'package:mcovidshield/model/tracker.dart';
import 'package:mcovidshield/util/database_helper.dart';
import 'package:mcovidshield/util/encryption.dart';
import 'package:mcovidshield/util/style.dart';

int collisionsCount = 0;

Future<int> fetchStatistics() async {
  DatabaseHelper db = new DatabaseHelper();
  db.getCollisionsCount().then((value) {
    print(' new home collisions value : '+ value.toString());
      collisionsCount = value;
  });
  return collisionsCount;
}

Widget CustomCard(BuildContext context,Tracker tracker){
  return FutureBuilder<int>(
    future: fetchStatistics(),
    builder: (context, snapshot) {
       return ClipRRect(
         borderRadius: BorderRadius.circular(15.0),
         child: Container(
           decoration: BoxDecoration(
             color: Colors.white,
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               SizedBox(
                 height: 15.0,
               ),
               Padding(
                 padding:
                 const EdgeInsets.symmetric(horizontal: 15.0),
                 child: Row(
                   children: <Widget>[
                     ClipRRect(
                       borderRadius: BorderRadius.circular(5),
                       child: Image.asset(
                         'assets/images/Flag.png',
                         fit: BoxFit.cover,
                         height: 35,
                         width: 35,
                       ),
                     ),
                     SizedBox(
                       width: 15.0,
                     ),
                     Text(
                       "${decryptMcovidShield(tracker.cin)}",
                       style: Theme.of(context)
                           .textTheme
                           .headline
                           .apply(
                           color: MyColors.primary,
                           fontWeightDelta: 2),
                     ),
                     Divider(height: 50,),
                   ],
                 ),
               ),
               SizedBox(
                 height: 15.0,
               ),
               Padding(
                 padding:
                 const EdgeInsets.symmetric(horizontal: 15.0),
                 child: RichText(
                   text: TextSpan(
                     children: [
                       WidgetSpan(
                         child: Icon(Icons.phone,color: MyColors.primary,),
                       ),
                       WidgetSpan(child:
                       SizedBox( width: 20,),
                       ),
                       TextSpan(
                         text: decryptMcovidShield(tracker.phone),
                         style: Theme.of(context)
                             .textTheme
                             .headline
                             .apply(
                             color: MyColors.primary,
                             fontWeightDelta: 2),
                       ),
                     ],
                   ),
                 ),
               ),
               SizedBox(
                 height: 15.0,
               ),
               Container(
                 padding: const EdgeInsets.all(25.0),
                 color: MyColors.red,
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text('Count of collisions :',
                       style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w300),
                     ),
                     Spacer(),
                     Text('${snapshot.data ?? 0 }',
                       style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                     ),
                   ],
                 ),
               )
             ],
           ),
         ),
       );
    },
  );
}