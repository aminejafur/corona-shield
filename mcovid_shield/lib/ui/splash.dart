import 'package:flutter/material.dart';
import 'package:mcovidshield/util/database_helper.dart';
import 'package:mcovidshield/util/style.dart';
import 'package:mcovidshield/main.dart';

class SplashApp extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashApp({
    Key key,
    @required this.onInitializationComplete,
  }) : super(key: key);

  @override
  _SplashAppState createState() => _SplashAppState();
}

class _SplashAppState extends State<SplashApp> {
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeAsyncDependencies();
  }

  Future<void> _initializeAsyncDependencies() async {
    DatabaseHelper db = new DatabaseHelper();
    var tracker = db.getTracker(1);
    Future.delayed(
      Duration(milliseconds: 1500),
          () => widget.onInitializationComplete(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_hasError) {
      return Scaffold(
        body: Center(
          child: RaisedButton(
            child: Text('retry'),
            onPressed: () => main(),
          ),
        ),
      );
    }
    return Scaffold(
      body: Center(child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(MyColors.red),
      )),
    );
  }
}