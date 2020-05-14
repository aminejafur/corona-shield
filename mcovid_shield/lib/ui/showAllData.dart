import 'package:flutter/material.dart';
import 'package:mcovidshield/model/tracker.dart';
import 'package:mcovidshield/widgets/alerts.dart';
import 'package:mcovidshield/util/database_helper.dart';
import 'package:mcovidshield/util/encryption.dart';
import 'package:mcovidshield/util/style.dart';

class allCollision extends StatefulWidget{
  @override
  _allCollisionState createState() => new _allCollisionState();
}

class _allCollisionState extends State<allCollision>{
  List collisionsList = new List();
  DatabaseHelper db = new DatabaseHelper();

  Future<Tracker> getTracker() async {
    return await db.getTracker(1) ?? null;
  }

  @override
  void initState() {
    super.initState();

    db.getAllCollisions().then((collisions){
      setState(() {
        collisions.forEach((collision){
          collisionsList.add(collision);
        });
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Collisions',
      home: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          title: Text('All Collisions'),
          centerTitle: true,
          backgroundColor:MyColors.primary,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: collisionsList.length,
              padding:const EdgeInsets.all(15.0),
              itemBuilder: (context , position){
                  return Column(
                  children: <Widget>[
                    Divider(height: 5.0,),
                    Row(
                      children: <Widget>[
                        new Expanded(
                            child: ListTile(
                              title: Text('${collisionsList[position]['mac']}',
                                style: TextStyle(fontSize: 22.0,color: MyColors.red
                                ),
                              ),
                              subtitle: Text('${decryptMcovidShield(collisionsList[position]['deviceName'])} - ${decryptMcovidShield(collisionsList[position]['dateCollision'])} ',
                                style: TextStyle(fontSize: 14.0,fontStyle: FontStyle.italic,
                                ),
                              ),
                              onTap: () => {},
                            )
                        ),
                        new Container(
                          height: 50,
                          width: 50,
                          color: Colors.transparent,
                          child: new Container(
                              decoration: new BoxDecoration(
                                  color: MyColors.red,
                                  borderRadius: new BorderRadius.all(Radius.circular(50))
                              ),
                              child: new Center(
                                child: new Text("${collisionsList[position]['count']}",style: TextStyle(color: MyColors.white,fontWeight: FontWeight.bold),),
                              )
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.cloud_upload),
            backgroundColor: MyColors.primary,
            onPressed: () => {
              getTracker().then((value) => {
                uploadAllData(context,collisionsList,value)
              })
            }),
      ),
    );
  }

}