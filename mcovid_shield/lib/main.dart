import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcovidshield/ui/Onboarding.dart';
import 'package:mcovidshield/ui/enter_blue_address.dart';
import 'package:mcovidshield/ui/home.dart';
import 'package:mcovidshield/ui/singup.dart';
import 'package:mcovidshield/util/bleutooth.dart';
import 'package:mcovidshield/util/checkInternet.dart';
import 'package:mcovidshield/util/database_helper.dart';
import 'package:mcovidshield/ui/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    SplashApp(
      key: UniqueKey(),
      onInitializationComplete: () => runMainApp(),
    ),
  );
}

Future<void> runMainApp() async {
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper db = new DatabaseHelper();
  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  dynamic tracker = await db.getTracker(1) ?? null;
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider.value(value: BlueToothProvider.initialize()),
      ],
    child: MaterialApp(
      title: 'Returning Data',
      home: getNextScreen(tracker),
    ),
    ),
  );
}

Widget getNextScreen(dynamic tracker) {
  print(tracker.toString());
  if(tracker == null){
    return OnBoardingPage(tracker);
  }else{
    if(tracker.phone == null){
      return Singup(tracker);
    }else if(tracker.mac == null){
      return BluetoothAddress(tracker);
    }else{
      return Home(tracker);
    }
  }
}