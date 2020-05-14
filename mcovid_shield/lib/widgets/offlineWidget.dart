import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcovidshield/util/style.dart';

Widget OfflineWidget(BuildContext context, String text){
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.signal_cellular_connected_no_internet_4_bar,size: 100,color: MyColors.white,),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,
            textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[100],fontWeight: FontWeight.w200),),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}