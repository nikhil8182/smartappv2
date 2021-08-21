import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:onwords_home/home_dash/wave.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'playbutton.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   var initializationSettingsAndroid =
//       AndroidInitializationSettings('launch_background');
//   var initializationSettingsIOS = IOSInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       onDidReceiveLocalNotification:
//           (int id, String title, String body, String payload) async {});
//   var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: (String payload) async {
//     if (payload != null) {
//       debugPrint('notification payload:' + payload);
//     }
//   });
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark()
//           .copyWith(scaffoldBackgroundColor: Color.fromARGB(255, 18, 32, 47)),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: HomePage(),
//       ),
//     );
//   }
// }



var water;
var powerStatus;
var data;
var battery;
var voltage;
var amp;
var price;
var light;
bool eBill = false;
bool door = false;
int count = 0;
int count1 = 0;
int count2 = 0;

class HomeDashPage extends StatefulWidget {
  const HomeDashPage({Key key}) : super(key: key);

  @override
  _HomeDashPageState createState() => _HomeDashPageState();
}

class _HomeDashPageState extends State<HomeDashPage> {

  Future<dynamic> getData() async {
    http.Response response =
        await http.get(Uri.parse('http://192.168.1.18:8000/'));
    data = json.decode(response.body);

    setState(() {
      battery = data['UPS_Battery_Percentage_About'];
      voltage = data['Onwords_Office_Voltage_Consuption_About'];
      amp = data['Onwords_Office_Amp_Consuption_About'];
      price = data['Onwords_Office_Current_Bill_About'];
      eBill = data['Eb_Status_About'];
      door = data['door_sensor'];
      powerStatus = data['Power_Saving_Mode_About'];
      light = data['Test_Lights_Button_Admin_Room'];
      water = data['level'];


    });
    if ((door == false) && (count == 0)) {
      scheduleNotification1();
      count++;
    } else if ((door == true) && (count == 1)) {
      scheduleNotification();
      count--;
    }

    if ((eBill == true) && (count1 == 0)) {
      scheduleNotificationEb();
      count1++;
    } else if ((eBill == false) && (count1 == 1)) {
      scheduleNotificationUps();
      count1--;
    }

  //   if(battery <=30 ) {
  //     powerStatus = true;
  //     print("power status === $powerStatus");
  //   }
  //   else if(battery >= 30){
  //     powerStatus = false;
  //     print("power status == $powerStatus");
  //   }
  // }

    if(light == true){
      startTimer();
    }
  }

  Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            powerStatus = http.get(Uri.parse('http://192.168.1.18:8000/Power_Saving_Mode_About/1/'));
            print("this is power $powerStatus");
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // getData();
    return Container(
      height: height * 1.0,
      width: width * 1.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Center(
                child: SizedBox(
                    height: height * 0.22,
                    width: width * 0.38,
                    child: PlayButton())),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 80.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent.withOpacity(0.20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      eBill
                          ? SvgPicture.asset(
                              "images/battery-svgrepo-com.svg",
                              height: 35.0,
                              color: Colors.red.shade100,
                            )
                          : SvgPicture.asset(
                              "images/battery-svgrepo-com.svg",
                              height: 35.0,
                              color: Colors.redAccent.shade700,
                            ),
                    ],
                  ),
                ),
                Container(
                  height: 80.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      eBill
                          ? SvgPicture.asset(
                              "images/bolt-svgrepo-com.svg",
                              height: 35.0,
                              color: Colors.greenAccent.shade700,
                            )
                          : SvgPicture.asset(
                              "images/bolt-svgrepo-com.svg",
                              height: 35.0,
                              color: Colors.green.shade200,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          eBill
              ? Text(
                  " Your Home is Powered!!",
                  style: TextStyle(fontWeight: FontWeight.w900),
                )
              : Text(" UPS is ON",
                  style: TextStyle(fontWeight: FontWeight.w900)),
          Divider(
            color: Color.fromARGB(255, 0, 159, 253),
            thickness: width * 0.001,
            indent: width * 0.09,
            endIndent: width * 0.09,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              child: Container(
                height: height * 0.08,
                width: width * 0.75,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 182, 140, 214),
                      Color.fromARGB(255, 113, 230, 222),
                    ],
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    "\₹ $price",
                    style: TextStyle(
                        fontSize: width * 0.085,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: height * 0.17,
                width: width * 0.31,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 5, 232, 186),
                        Color.fromARGB(255, 8, 126, 232),
                      ],
                      stops: [0.0, 1.0],
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, bottom: 3.0),
                        child: Text(
                          "$voltage",
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 10.0, bottom: 5.0),
                        child: Text(
                          "Voltage Consumption",
                          style: TextStyle(fontSize: 9.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                        child: CustomPaint(
                          //
                          size: Size(90, 30),
                          painter: MyPainter(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 150.0,
                width: 130.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 0, 159, 253),
                      Color.fromARGB(255, 42, 42, 114),
                    ],
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, bottom: 3.0),
                        child: Text(
                          "$amp",
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 10.0, bottom: 5.0),
                        child: Text(
                          "AMP Consumption",
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                        child: CustomPaint(
                          //
                          size: Size(90, 30),
                          painter: MyPainter(),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 150.0,
                width: 130.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 0, 159, 253),
                      Color.fromARGB(255, 42, 42, 114),
                    ],
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10.0, bottom: 3.0),
                            child: Text(
                              "$water",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, left: 10.0, bottom: 5.0),
                            child: Text(
                              "Water Level",
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17.0,right: 2.0,left: 2.0),
                      child: DemoPage(),
                    ),
                  ],
                ),
              ),
              Container(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  height: 150.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                    gradient: door
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 164, 6, 6),
                              Color.fromARGB(255, 217, 131, 60),
                            ],
                            stops: [0.0, 1.0],
                          )
                        : LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 35, 51, 41),
                              Color.fromARGB(255, 99, 212, 113),
                            ],
                            stops: [0.0, 1.0],
                          ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: door
                        ? Text(
                            "Door is Opened 😊 ",
                            style: TextStyle(
                                fontSize: width * 0.050,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          )
                        : Text(
                            "Door is Closed 😁 ",
                            style: TextStyle(
                                fontSize: width * 0.050,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(milliseconds: 100));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "popup",
      "popup",
      "small popups",
      importance: Importance.max,
      priority: Priority.high,
      icon: 'launch_background',
      sound: RawResourceAndroidNotificationSound('iphone_notification'),
      largeIcon: DrawableResourceAndroidBitmap('launch_background'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Admin Room',
        'Door Is Opened',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future<void> scheduleNotification1() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(milliseconds: 100));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "popup",
      "popup",
      "small popups",
      importance: Importance.max,
      priority: Priority.high,
      icon: 'launch_background',
      sound: RawResourceAndroidNotificationSound('iphone_notification'),
      largeIcon: DrawableResourceAndroidBitmap('launch_background'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Admin Room',
        'Door Is Closed',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future<void> scheduleNotificationEb() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(milliseconds: 100));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "popup",
      "popup",
      "small popups",
      importance: Importance.max,
      priority: Priority.high,
      icon: 'launch_background',
      sound: RawResourceAndroidNotificationSound('iphone_notification'),
      largeIcon: DrawableResourceAndroidBitmap('launch_background'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Home',
        'Your home is Powered',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future<void> scheduleNotificationUps() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(milliseconds: 100));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "popup",
      "popup",
      "small popups",
      importance: Importance.max,
      priority: Priority.high,
      icon: 'launch_background',
      sound: RawResourceAndroidNotificationSound('iphone_notification'),
      largeIcon: DrawableResourceAndroidBitmap('launch_background'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(0, 'Home', 'UPS is ON',
        scheduledNotificationDateTime, platformChannelSpecifics);
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pointMode = ui.PointMode.polygon;
    final points = [
      Offset(2, 20),
      Offset(15, 5),
      Offset(35, 25),
      Offset(55, 5),
      Offset(75, 15),
      Offset(85, 5),
    ];
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
