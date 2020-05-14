import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mcovidshield/model/statistics.dart';
import 'package:mcovidshield/widgets/counter_animation.dart';
import 'package:mcovidshield/util/globalVars.dart';
import 'package:http/http.dart' as http;
import 'package:mcovidshield/util/style.dart';

class CoronaStatistics extends StatefulWidget {
  @override
  _CoronaStatisticsState createState() => new _CoronaStatisticsState();
}

class _CoronaStatisticsState extends State<CoronaStatistics> with SingleTickerProviderStateMixin{

  Future<Statistics> fetchStatistics() async {
    final response = await http.get(MyVars.statisticsUrl);
    if (response.statusCode == 200) {
      return Statistics.fromJson(json.decode(response.body));
    } else {
      print('Failed to load Statistics');
      throw Exception('Failed to load Statistics');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Statistics>(
      future: fetchStatistics(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AnimatedCount(count: snapshot.data.confirmed,status: 'Cases'),
                          Text(
                            "${snapshot.data.todayConfirmed.toString()} Today",
                            style: Theme.of(context)
                                .textTheme
                                .body2
                                .apply(color: Colors.white70),
                          )
                        ],
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: CircularProgressIndicator(
                                value: .25,
                                backgroundColor: MyColors.red,
                                valueColor: AlwaysStoppedAnimation(
                                    Colors.white),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                snapshot.data.casesIcon ? Icons.call_missed_outgoing : Icons.call_received,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AnimatedCount(count: snapshot.data.recovered,status: 'Recovery'),
                          Text(
                            "${snapshot.data.todayRecovered ?? '...'  } Today",
                            style: Theme.of(context)
                                .textTheme
                                .body2
                                .apply(color: Colors.white70),
                          )
                        ],
                      ),

                      Container(
                        height: 50,
                        width: 50,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: CircularProgressIndicator(
                                value: .25,
                                backgroundColor: MyColors.red,
                                valueColor: AlwaysStoppedAnimation(
                                    Colors.white),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                snapshot.data.recoversIcon ? Icons.call_missed_outgoing : Icons.call_received,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AnimatedCount(count: snapshot.data.deaths,status: 'Deaths'),
//                          Text(
//                              "${snapshot.data.deaths ?? '...' } Deaths",
//                              style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w200)
//                          ),
                          Text(
                            "${snapshot.data.todayDeaths.toString()} Today",
                            style: Theme.of(context)
                                .textTheme
                                .body2
                                .apply(color: Colors.white70),
                          )
                        ],
                      ),

                      Container(
                        height: 50,
                        width: 50,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: CircularProgressIndicator(
                                value: .25,
                                backgroundColor: MyColors.red,
                                valueColor: AlwaysStoppedAnimation(
                                    Colors.white),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                snapshot.data.deathsIcon ? Icons.call_missed_outgoing : Icons.arrow_downward,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),

                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AnimatedCount(count: snapshot.data.tests,status: 'Tests'),
//                          Text(
//                              "${snapshot.data.tests ?? '...' } Tests",
//                              style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w200)
//                          ),
                        ],
                      ),

                      Container(
                        height: 50,
                        width: 50,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: CircularProgressIndicator(
                                value: 100,
                                backgroundColor: MyColors.red,
                                valueColor: AlwaysStoppedAnimation(
                                    Colors.white),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.contacts,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          );
        } else {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(MyColors.white),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}