import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mcovidshield/model/tracker.dart';
import 'package:mcovidshield/util/checkInternet.dart';
import 'package:mcovidshield/widgets/corona_statistics.dart';
import 'package:mcovidshield/widgets/custom_card.dart';
import 'package:mcovidshield/widgets/custom_navbar.dart';
import 'package:mcovidshield/widgets/offlineWidget.dart';
import 'package:mcovidshield/util/style.dart';
import 'package:mcovidshield/util/database_helper.dart';

class Home extends StatefulWidget {
  final Tracker tracker;
  Home(this.tracker);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  StreamSubscription _connectionChangeStream;
  bool isOffline = false;
  DatabaseHelper db = new DatabaseHelper();
  int collisionsCount = 0;
  AnimationController controller;
  Animation<Offset> offset;

  @override
  initState() {
    super.initState();

    db.getCollisionsCount().then((value) {
      print(' home collisions value : '+ value.toString());
      setState(() {
        collisionsCount = value;
      });
    });

    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    _connectionChangeStream = connectionStatus.connectionChange.listen(connectionChanged);

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(controller);
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
      /*print('isOffline ' + isOffline.toString());*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Hello,",
                        textAlign: TextAlign.right,
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .apply(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomCard(context,widget.tracker),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                   children: <Widget>[
                     Text(
                       "${widget.tracker.mac.substring(0,20)}",
                       textAlign: TextAlign.start,
                       style: Theme.of(context)
                           .textTheme
                           .subtitle
                           .apply(color: Colors.white70),
                     ),
                   ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  (isOffline) ?
                  OfflineWidget(context,"Your Internet is turned off, please turn on the Internet and we will bring the data for you!")
                  :
                  CoronaStatistics(),
                ],
              ),
            ),
          ),
          CustomNavbar(context),
        ],
      ),
    );
  }
}