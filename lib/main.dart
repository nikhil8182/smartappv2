import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:onwords_home/home_page.dart';
import 'package:onwords_home/log_ins/login_page.dart';
import 'package:overlay_support/overlay_support.dart';
// import 'package:onwords_home/splashScreen.dart';
//import 'package:onwords_home/home_page.dart';
import 'package:provider/provider.dart';
import 'Routine_Page/task_data.dart';
//import 'log_ins/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


//last cloned  09-sep 5-32 pm

FirebaseAuth auth = FirebaseAuth.instance;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  var initializationSettingsAndroid =
  AndroidInitializationSettings('launch_background');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,//backup code
      requestSoundPermission: true,//parthosh
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload:' + payload);
        }
      });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TaskData(),
      child: OverlaySupport.global(
        child: MaterialApp(
        // theme: ThemeData.dark()
        //     .copyWith(scaffoldBackgroundColor: Color.fromARGB(255, 18, 32, 47)),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body:LoginPage(),
        ),
        ),
      ),
    );
  }
}
