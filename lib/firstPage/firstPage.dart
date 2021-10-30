import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:onwords_home/firstPage/gridFirstPage.dart';
import 'package:onwords_home/firstPage/listFirstPage.dart';
import 'package:onwords_home/firstPage/weatherService.dart';
import 'package:overlay_support/overlay_support.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




FirebaseAuth auth = FirebaseAuth.instance;
final databaseReference = FirebaseDatabase.instance.reference();

class FirstPage extends StatefulWidget {

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>{
  var dataJson;

  SharedPreferences loginData;
  String userName = " ";
  String ipAddress;
  String ipLocal = " ";

  String ip;
  String username;
  bool notifier = false;
  bool mobNotifier = false;
  bool wifiNotifier = false;
  bool currentIndex = false;
  bool _pinned = true;
  bool _floating = false;
  Timer timer;
  bool hasInternet = false;
  List data = [];
  var sharedDataValues;
  List<String> localDataVal = [ ];
  ConnectivityResult result = ConnectivityResult.none;
  Gradient g1 = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.grey[800],
        Colors.grey[800],
      ]);


  Future <void> initial() async {
    //print("im inside the initial second");
    loginData = await SharedPreferences.getInstance();
    // setState(() {
    //   username = loginData.getString('username');
    //   ipAddress = loginData.getString('ip');
    //   });
    username = loginData.getString('username');
    ipAddress = loginData.getString('ip');
    // print("$ipAddress inside the initial() in FirstPage");
    // print("$username inside the initial() in FirstPage");
    localDataVariableStorage();
  }

  localDataVariableStorage() async {

    if (ipAddress.toString().toLowerCase() != "false") {
      //print("iam using online json");
      //print("in the getname insid ethe  $ipAddress");
      final response = await http.get(Uri.parse(
        "http://$ipAddress/key",
      ));

      var fetchdata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // data = fetchdata;
        setState(() {
          data = fetchdata;
          for(int i =0; i<data.length ; i++){
            localDataVal.add(data[i].toString());
          }
          loginData.setStringList('dataValues', localDataVal);
          // print(data);
        });
      }
    }else if (ipAddress.toLowerCase().toString() == "false"){
      setState(() {
        data = dataJson.keys.toList();
        for(int i =0; i<data.length ; i++){
          localDataVal.add(data[i].toString());
        }
        loginData.setStringList('dataValues', localDataVal);
      });
    }else{
      print("surprise motherFucker");
    }
    //sharedDataValues = loginData.getStringList('dataValues');
  }



  Future<void> fireData() async {
    //print("im at before atlast of firedata");
    databaseReference.child(auth.currentUser.uid).once().then((DataSnapshot snapshot) async {

      dataJson = snapshot.value;
      // data1 = dataJson.keys.toList();
      print(dataJson);
      userName = dataJson["name"];
      ipLocal = dataJson["ip"].toString();
      print("$userName user name is firedata");
      print("$ipLocal  ipLocal is firedata");
      checkData();
      //ipAddress = loginData.getString('ip');
      //print("im at atlast of firedata");
    });
    //print("above checkData");
    //checkData();
  }

  checkData() async {
    print("im inside the data");
    loginData = await SharedPreferences.getInstance();
    loginData.setString('ip', ipLocal );
    loginData.setString('username', userName);
    getData();
  }


  getData(){
    print("im inside the get Data");
    initial();
    if((!wifiNotifier) && (result == ConnectivityResult.wifi)) {
      if((!wifiNotifier) && (ipAddress.toString().toLowerCase() != 'false')){
      }else{
        showSimpleNotification(
          Text(" Please Connect to your wiFi Network ",
            style: TextStyle(color: Colors.white),), background: Colors.red,
        );
      }
      wifiNotifier = true;
    }else if((result == ConnectivityResult.mobile)&&(!mobNotifier)){
      if((!mobNotifier) && (ipAddress.toString().toLowerCase() == 'false')){
        showSimpleNotification(
          Text(" your are on Demo Login by Mobile Data   ",
            style: TextStyle(color: Colors.white),), background: Colors.green,
        );
      }else{
        showSimpleNotification(
          Text(" please switch to wifi network   ",
            style: TextStyle(color: Colors.white),), background: Colors.green,
        );
      }
      mobNotifier = true;
    }

    //important recently committed
    // else if((result == ConnectivityResult.none)&&(!notifier))
    // {
    //   if(!notifier){
    //     //showWifiNetAlertDialog(context);
    //     showSimpleNotification(
    //       Text(" No Internet Connectivity",
    //         style: TextStyle(color: Colors.white),), background: Colors.red,
    //     );
    //     // showWifiNetAlertDialog(context);
    //   }
    //   notifier = true;
    // }

  }


   internet() async {
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        this.result = result;
      });
    });
    InternetConnectionChecker().onStatusChange.listen((status) async {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
    hasInternet = await InternetConnectionChecker().hasConnection;
    result = await Connectivity().checkConnectivity();
  }

  @override
  void initState() {
    // timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
    //   fireData();
    // });
    internet();
    fireData();
    // timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
    //   getData();
    // });
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
        onWillPop: () => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        backgroundColor: Colors.black.withOpacity(0.9),
        title: Text('Warning',style: TextStyle(color: Colors.white60,fontWeight: FontWeight.bold),),
        content: Text('Do you really want to exit',style: TextStyle(color: Colors.white60),),
        actions: [
          TextButton(
            child: Text('Yes'),
            onPressed: () => Navigator.pop(context, true),
          ),
          TextButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    ),
    child: SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(26, 28, 30, 0.6),
        body: Container(
          height: height * 1.0,
          width: width * 1.0,
          color: Color.fromRGBO(26, 28, 30, 0.6),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                // backgroundColor: Color.fromRGBO(40, 36, 36, 1.0),
                backgroundColor: Color.fromRGBO(26, 28, 30, 0.6),
                collapsedHeight: height * 0.099,
                pinned: _pinned,
                // snap: _snap,
                floating: _floating,
                expandedHeight: height * 0.164,
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Home",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: height * 0.031,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        username??" ",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w300, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              // SliverToBoxAdapter(
              //   // child: Container(
              //   //   // color: Color.fromRGBO(40, 36, 36, 1.0),
              //   //   color: Color.fromRGBO(26, 28, 30, 0.6),
              //   //   child: Padding(
              //   //     padding: EdgeInsets.all(18.0),
              //   //     child: Container(
              //   //       height: height * 0.10,
              //   //       width: width * 0.80,
              //   //       decoration: BoxDecoration(
              //   //         gradient: LinearGradient(
              //   //           begin: Alignment.bottomLeft,
              //   //           end: Alignment.topRight,
              //   //           colors: [
              //   //             Color.fromRGBO(247, 179, 28,1.0),
              //   //             Color.fromRGBO(255, 210, 112,1.0),
              //   //           ],
              //   //           stops: [0.1,0.7],
              //   //         ),
              //   //         borderRadius: BorderRadius.circular(20.0),
              //   //         boxShadow: [
              //   //           BoxShadow(
              //   //             color: Colors.white38,
              //   //             offset: Offset(
              //   //               -2.5,
              //   //               -0.5,
              //   //             ),
              //   //             blurRadius: 6.0,
              //   //             spreadRadius: 1.0,
              //   //           ),
              //   //           BoxShadow(
              //   //             color: Colors.black,
              //   //             offset: Offset(
              //   //               2.5,
              //   //               2.5,
              //   //             ),
              //   //             blurRadius: 10.0,
              //   //             spreadRadius: 1.0,
              //   //           ),
              //   //         ],
              //   //       ),
              //   //       child: Padding(
              //   //         padding: EdgeInsets.symmetric(horizontal: 15.0),
              //   //         child: Row(
              //   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   //           children: [
              //   //             Column(
              //   //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   //               children: [
              //   //                 Text("Partially cloudy"),
              //   //                 Text(
              //   //                   "32°C",
              //   //                   style: GoogleFonts.montserrat(
              //   //                     fontSize: height*0.045,
              //   //                     fontWeight: FontWeight.bold,
              //   //                   ),
              //   //                 )
              //   //               ],
              //   //             ),
              //   //             Image(
              //   //               image: AssetImage("images/cloud.png"),
              //   //               height: height * 0.085,
              //   //             )
              //   //           ],
              //   //         ),
              //   //       ),
              //   //     ),
              //   //   ),
              //   // ),
              //   child: GeoLocationPage(),
              // ),
              SliverToBoxAdapter(
                child: Container(
                  // color: Color.fromRGBO(40, 36, 36, 1.0),
                  color: Color.fromRGBO(26, 28, 30, 0.6),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        currentIndex ?
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            size: height*0.042,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              if (currentIndex == false) {
                                currentIndex = true;
                              } else if (currentIndex == true) {
                                currentIndex = false;
                              }
                            });
                          },
                        ):GestureDetector(
                            onTap: (){
                              setState(() {
                                if (currentIndex == false) {
                                  currentIndex = true;
                                } else if (currentIndex == true) {
                                  currentIndex = false;
                                }
                              });
                            },
                            child: Image(image: AssetImage('images/icon.png'),height: height*0.023,)),
                      ],
                    ),
                  ),
                ),
              ),
              currentIndex?
              FirstPageGridContainer():
              FirstPageListContainers(),
            ],
          ),
        ),
      ),
    ),
    );
  }

  // showWifiNetAlertDialog(BuildContext context) {
  //   // Create button
  //   Widget okButton = TextButton(
  //     child: Text("ok"),
  //     onPressed: (){
  //       notifier = false;
  //       mobNotifier = false;
  //       wifiNotifier = false;
  //       getData();
  //       Navigator.pop(context, false);
  //     },
  //   );
  //   // Create AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     backgroundColor: Colors.white.withOpacity(0.2),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  //     title: Text(" No Internet ",style: TextStyle(color: Colors.white60,fontWeight: FontWeight.bold),),
  //     content: Text("please connect your device with Internet  ",style: TextStyle(color: Colors.white60),),
  //     actions: [
  //       okButton,
  //     ],
  //   );
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert ;
  //     },
  //   );
  // }
  showAnotherAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("ok"),
      onPressed: (){
        notifier = false;
        mobNotifier = false;
        wifiNotifier = false;
        getData();
        Navigator.pop(context, false);
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text("Oops!!!! ",style: TextStyle(color: Colors.white60,fontWeight: FontWeight.bold),),
      content: Text("please connect your device with Local WiFi Network  ",style: TextStyle(color: Colors.white60),),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert ;
      },
    );
  }
}
