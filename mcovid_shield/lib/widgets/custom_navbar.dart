import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:mcovidshield/ui/discover.dart';
import 'package:mcovidshield/widgets/alerts.dart';
import 'package:mcovidshield/util/screen_navigation.dart';
import 'package:mcovidshield/util/style.dart';

Widget CustomNavbar(BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width / 5,
    color: MyColors.primary,
    child: Column(
      children: <Widget>[
        Expanded(
          child: IconButton(
            icon: Icon(
              Icons.public,
              color: Colors.white,
            ),
            onPressed: () {
              showComingsoon(context);
            },
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(
              Icons.perm_identity,
              color: Colors.white,
            ),
            onPressed: () {
              showComingsoon(context);
            },
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(
              Icons.format_list_bulleted,
              color: Colors.white,
            ),
            onPressed: () {
              showAllData(context);
            },
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            onPressed: () {
              exitModal(context);
            },
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(PageTransition(type: PageTransitionType.rippleRightUp, child: Discover()));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                ),
                color: MyColors.red,
              ),
              child: Transform.rotate(
                angle: -pi / 2,
                child: Row(
                  children: <Widget>[
                    Transform.rotate(
                      angle: pi/2,
                      child: Icon(Icons.wifi_tethering, color: Colors.white,size: 40,),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

