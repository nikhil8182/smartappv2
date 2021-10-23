import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onwords_home/log_ins/login_page.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'Routine_Page/task_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

//master version v3.1
//last cloned  24-sep 2-30 pm

FirebaseAuth auth = FirebaseAuth.instance;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  ///notification
  // var initializationSettingsAndroid =
  // AndroidInitializationSettings('launch_background');
  // var initializationSettingsIOS = IOSInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,//backup code
  //     requestSoundPermission: true,//parthosh
  //     onDidReceiveLocalNotification:
  //         (int id, String title, String body, String payload) async {});
  // var initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String payload) async {
  //       if (payload != null) {
  //         debugPrint('notification payload:' + payload);
  //       }
  //     });

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
