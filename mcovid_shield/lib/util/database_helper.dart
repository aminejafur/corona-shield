import 'dart:async';

import 'package:mcovidshield/model/colistiondata.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mcovidshield/model/tracker.dart';

class DatabaseHelper {
  /*Tracker*/
  final String tableTracker = 'TrackerTable';
  final String columnId = 'id';
  final String columnPhone = 'phone';
  final String columnCin = 'cin';
  final String columnMacAddress = 'mac';
  final String columnCollisions = 'collisions';
  final String columnMoreInfo = 'moreinfo';

  /*Collisions*/
  final String tableCollisions = 'CollisionsTable';
  final String columnUserID = 'idUser';
  final String columndeviceName = 'deviceName';
  final String columndate = 'dateCollision';

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Trackers.db');


    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableTracker($columnId INTEGER PRIMARY KEY, '
            '$columnPhone TEXT, $columnCin TEXT'
            ', $columnCollisions TEXT, $columnMacAddress TEXT'
            ', $columnMoreInfo TEXT)');

    await db.execute(
        'CREATE TABLE $tableCollisions($columnId INTEGER PRIMARY KEY, '
            '$columnUserID INTEGER, $columnMacAddress TEXT'
            ', $columndeviceName TEXT, $columndate TEXT)');
  }

  Future<int> saveCollision(Collision collision) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableCollisions, collision.toMap());
    return result;
  }
  
  Future<int> saveTracker(Tracker tracker) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableTracker, tracker.toMap());
    return result;
  }

  Future<List> getAllTrackers() async {
    var dbClient = await db;
    var result = await dbClient.query(
        tableTracker,
        columns: [columnId, columnPhone, columnCin, columnCollisions, columnMacAddress, columnMoreInfo]);

    return result.toList();
  }

  Future<int> getCollisionsCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(DISTINCT $columnMacAddress) FROM $tableCollisions'));
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableTracker'));
  }

  Future<Tracker> getTracker(int id) async {
    var dbClient = await db;

    List<Map> result = await dbClient.query(tableTracker,
        columns: [columnId, columnPhone, columnCin, columnCollisions, columnMacAddress, columnMoreInfo],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return new Tracker.fromMap(result.first);
    }

    return null;
  }


  Future<int> updateTracker(tracker) async {
    var dbClient = await db;
    return await dbClient.update(
        tableTracker, tracker.toMap(), where: "$columnId = ?", whereArgs: [tracker.id]
    );
  }

  Future<List> getAllCollisions() async {
    var dbClient = await  db;
    List result = await dbClient.rawQuery( "SELECT * , COUNT(*) as count FROM $tableCollisions GROUP BY $columnMacAddress");
    if (result.length > 0){ return result; }
    return null;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
