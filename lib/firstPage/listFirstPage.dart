import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firstpagefuntions.dart';
import 'individual_page.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final databaseReference = FirebaseDatabase.instance.reference();

class FirstPageListContainers extends StatefulWidget {
  @override
  _FirstPageListContainersState createState() =>
      _FirstPageListContainersState();
}

class _FirstPageListContainersState extends State<FirstPageListContainers> {

  bool wifiNotifier = false;
  bool notifier = false;
  bool mobNotifier = false;
  bool adminStatus = false;
  bool kitchenStatus = false;
  bool hallStatus = false;
  bool bedRoomStatus = false;
  bool bedRoom1Status = false;
  bool bedRoom2Status = false;
  bool masterBedStatus = false;
  bool bathRoomStatus = false;
  bool garageStatus = false;
  bool gardenStatus = false;
  bool storeStatus = false;
  bool parkingStatus = false;
  bool livingStatus = false;
  bool outSideStatus = false;
  bool status = false;
  int statusInt = 0;
  List toggleValues = [];
  int intValue = 0;
  String ip;
  Gradient g1 = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.grey[800],
        Colors.grey[800],
      ]);

  bool currentIndex = false;
  bool valueStatus = false;
  List name = [];
  List pg = [];
  List data = [];
  List data1 = [];
  bool first;
  SharedPreferences loginData;
  var sharedDataValues;
  String userName = " ";
  String ipAddress = " ";
  String ipLocal = " ";
  Timer timer;
  bool hasInternet = false;
  String username ;
  ConnectivityResult result = ConnectivityResult.none;
  var acount = 0;
  var dataJson;
  List<String> localDataVal = [ ];
  var count = 0;

  Future <void> initial() async {
    print("im inisde the initial state of list");
    loginData = await SharedPreferences.getInstance();
      username = loginData.getString('username');
      ipAddress = loginData.getString('ip');
      data =  loginData.getStringList('dataValues');
    print("$ipAddress im inside the initial state in listPage");
    print("$username im inside the initial state in listPage");
    print("$data im inside the initial state in listPage");
    print("$data in initial of list page");
    if(ipAddress == null){
      print("data is null in if state of list ");
      fireData();
    }else if(data == null) {
      print("sucker!!!!!!!!!!!!!!!!!!!!");
  if(ipAddress.toString() != 'false'){
    print("im inside the else if of initial **************");
    final response = await http.get(Uri.parse(
      "http://$ipAddress/key",
    ));
    var fetchdata = jsonDecode(response.body);
    if (response.statusCode >0) {
      // data = fetchdata;
      setState(() {
        data = fetchdata;
        for(int i =0; i<data.length ; i++){
          localDataVal.add(data[i].toString());
        }
        print("im local in if loop data in list $localDataVal");
        loginData.setStringList('dataValues', localDataVal);
        initial();
        // print(data);
      });
    }
  }}else {
      print("im going into the getName of list");
      getName();
    }
  }

  Future<void> fireData() async {
    print("im at before atlast of firedata");
    databaseReference.child(auth.currentUser.uid).once().then((DataSnapshot snapshot) async {
     print("im inside the firedata of list page");
      dataJson = snapshot.value;
      // data1 = dataJson.keys.toList();
      print(dataJson);
      userName = dataJson["name"];
      ipLocal = dataJson["ip"].toString();
      print("$userName user name is firedata");
      print("$ipLocal  ipLocal is firedata");
      loginData.setString('ip', ipLocal );
      loginData.setString('username', userName);
      localDataVariableStorage();
      //ipAddress = loginData.getString('ip');
      //print("im at atlast of firedata");
    });
    //print("above checkData");
    //checkData();
  }
  localDataVariableStorage() async {
    print("im abov ethe initial state on local DataVar");
    initial();
    print("im inside the localdata of list page");
    if ((ipAddress.toString().toLowerCase() != "false") && (ipAddress.toString() != null)) {
      print("iam using online json in below if class and ip address is $ipAddress");
      if(result == ConnectivityResult.wifi)
      {
        print("in the inside the if o local data of storage inside ethe  $ipAddress");
        final response = await http.get(Uri.parse(
          "http://$ipAddress/key",
        ));
        var fetchdata = jsonDecode(response.body);
        if (response.statusCode >0) {
          // data = fetchdata;
          setState(() {
            data = fetchdata;
            for(int i =0; i<data.length ; i++){
              localDataVal.add(data[i].toString());
            }
            print("im local in if loop data in list $localDataVal");
            loginData.setStringList('dataValues', localDataVal);
            initial();
            // print(data);
          });
        }
      }else if(result == ConnectivityResult.mobile){
        if(count < 1) {
          //showAnotherAlertDialog(context);
          showSimpleNotification(
            Text(" plaese im from else con for localDataVariableStorage ",
              style: TextStyle(color: Colors.white),), background: Colors.red,
          );
          count = 2;
        }
      }else{
        print("no internet in wifi in list page");
      }

    }else if ((ipAddress.toLowerCase().toString() == "false") && (ipAddress.toString() != null)){
      print("im inisde the else if ");
      if(result == ConnectivityResult.mobile){
        setState(() {
          data = dataJson.keys.toList();
          for(int i =0; i<data.length ; i++){
            localDataVal.add(data[i].toString());
          }
          print("im local in else if loop data $localDataVal");
          loginData.setStringList('dataValues', localDataVal);
        });
      } else if(result == ConnectivityResult.wifi){
        //print some add some functionality
        print("*********im inside the else if of ip Address and inside the esle state********");
      }
    }
    //sharedDataValues = loginData.getStringList('dataValues');
  }

  wiFiChecker() {
    print("im wifichecker");
    if (result == ConnectivityResult.wifi){
      //getName();
      print("hello im wifi");
      if ((acount == 0) && (ipAddress.toString().toLowerCase() != 'false')){
        print("im iniside the wifi");
        if(acount<1) {
          showSimpleNotification(
            Text(
              " your on wifi network ",
              style: TextStyle(color: Colors.white),
            ),
            background: Colors.green,
          );
          acount = 2;
        }
      }else if(ipAddress == null){
        print("im inside the wifi of else if con");
        initial();
      }
      initial();
    }
    else if((result == ConnectivityResult.mobile)){
      print("hello im mobile");
      if ((acount == 0) && (ipAddress.toString().toLowerCase() != 'false')) {
        print("im iniside the mobile ");
        if (acount < 1){
          showSimpleNotification(
            Text(" your are on Demo Login by Mobile Data   ",
              style: TextStyle(color: Colors.white),), background: Colors.green,
          );
          acount = 2;
        }
        // getName();
        // localData();
      }
    }
    else{
      print("i am not connected to anything in wifi checker ___------------");
    }
  }

    //
    // Future<void> getData() async {
    //   // fireData();
    //   initial();
    //
    //   // if (result == ConnectivityResult.wifi) {
    //   //   // print("wifi in listPage =============_________(((((((((()))))))");
    //   //   // print("$ipAddress =============------+++++++++++@@@@@@ ");
    //   //   // localData();
    //   //   getName();
    //   // } else if ((result == ConnectivityResult.mobile) && (!mobNotifier)) {
    //   //   // print("mobile in listPage****************************");
    //   //   // print("$ipAddress =============------+++++++++++@@@@@@ ");
    //   //
    //   //   if ((!mobNotifier) && (ipAddress.toString().toLowerCase() == 'false')) {
    //   //
    //   //     showSimpleNotification(
    //   //       Text(" your are on Demo Login by Mobile Data   ",
    //   //         style: TextStyle(color: Colors.white),), background: Colors.green,
    //   //     );
    //   //     // initial();
    //   //     getName();
    //   //     localData();
    //   //     // localData();
    //   //   }
    //   //   else {
    //   //     //showWifiNetAlertDialog(context);
    //   //     showSimpleNotification(
    //   //       Text(
    //   //         " please switch on your wifi network ",
    //   //         style: TextStyle(color: Colors.white),
    //   //       ),
    //   //       background: Colors.red,
    //   //     );
    //   //   }
    //   //   mobNotifier = true;
    //   // }
    //   // else if ((result == ConnectivityResult.none) && (!notifier)) {
    //   //   //print(" ************** none in listPage **************");
    //   //   // print("$notifier the value of the notifier is 00000000");
    //   //   if (!notifier) {
    //   //     // print(" im inside the if notifier class");
    //   //     //showAnotherAlertDialog(context);
    //   //     showSimpleNotification(
    //   //       Text(
    //   //         " No Internet Connectivity ",
    //   //         style: TextStyle(color: Colors.white),
    //   //       ),
    //   //       background: Colors.red,
    //   //     );
    //   //   }
    //   //   showAnotherAlertDialog(context);
    //   //   notifier = true;
    //   // }
    //   // });
    //
    //   // username = loginData.getString('username');
    // }
    //

  Future<void> toggleButton(int index, int sts) async {
    setState(() {
      intValue = 0;
    });
    toggleValues.clear();
    for (int i = 0; i < data.length; i++) {
      if (data[i].toString().contains(name[index].toString())) {
        toggleValues.add(data[i].toString());
      }
    }
    for (int i = 0; i < toggleValues.length; i++) {
      print(toggleValues[i]);
      while (intValue < 2) {
        // print(toggleValues[i]);
        // print("$ipAddress =======");
        // ip = loginData.getString('ip');
        await http.get(Uri.parse('http://$ipAddress/${toggleValues[i]}/$sts'));
        intValue++;
        print(intValue);
      }
      setState(() {
        intValue = 0;
      });
    }
  }



  Future getName() async {

    print("im inside the getname of list funtion");
    for (int i = 0; i < data.length; i++) {

      if (data[i].toString().contains("_Admin_Room") &&
          (!name.contains(data[i].toString().contains("Admin_Room")))) {
        name.add("Admin_Room");
        pg.add("Admin_Room");
      } else if (data[i].toString().contains("_Hall") &&
          (!name.contains(data[i].toString().contains("Hall")))) {
        name.add("Hall");
        pg.add("Hall");
      } else if (data[i].toString().contains("Living_Room") &&
          (!name.contains(data[i].toString().contains("Living_Room")))) {
        name.add("Living_Room");
        pg.add("Living_Room");
      } else if (data[i].toString().contains("_Garage") &&
          (!name.contains(data[i].toString().contains("Garage")))) {
        name.add("Garage");
        pg.add("Garage");
      } else if (data[i].toString().contains("_Kitchen") &&
          (!name.contains(data[i].toString().contains("Kitchen")))) {
        name.add("Kitchen");
        pg.add("Kitchen");
      } else if (data[i].toString().contains("_Bathroom") &&
          (!name.contains(data[i].toString().contains("Bathroom")))) {
        name.add("Bathroom");
        pg.add("Bathroom");
      } else if (data[i].toString().contains("Master_Bedroom") &&
          (!name.contains(data[i].toString().contains("Master_Bedroom")))) {
        name.add("Master_Bedroom");
        pg.add("Master_Bedroom");
      } else if (data[i].toString().contains("_Bedroom1") &&
          !name.contains(data[i].toString().contains("Bedroom1"))) {
        name.add("Bedroom1");
        //print("----- bedroom1 $name name -------");
        pg.add("Bedroom1");
        //print("----- bedroom1 $pg pg -------");
      } else if (data[i].toString().contains("_Bedroom2") &&
          (!name.contains(data[i].toString().contains("Bedroom2")))) {
        name.add("Bedroom2");
        //print("----- bedroom1 $name name -------");
        pg.add("Bedroom2");
        //print("----- bedroom1 $pg pg -------");
      } else if (data[i].toString().contains("_Bedroom") &&
          (!name.contains(data[i].toString().contains("Bedroom")))) {
        name.add("Bedroom");
        pg.add("Bedroom");
      } else if (data[i].toString().contains("_Store_Room") &&
          (!name.contains(data[i].toString().contains("Store_Room")))) {
        name.add("Store_Room");
        pg.add("Store_Room");
      } else if (data[i].toString().contains("_Outside") &&
          (!name.contains(data[i].toString().contains("Outside")))) {
        name.add("Outside");
        pg.add("Outside");
      } else if (data[i].toString().contains("_Parking") &&
          (!name.contains(data[i].toString().contains("Parking")))) {
        name.add("Parking");
        pg.add("Parking");
      } else if (data[i].toString().contains("_Outside") &&
          (!name.contains(data[i].toString().contains("Outside")))) {
        name.add("Outside");
        pg.add("Outside");
      } else if (data[i].toString().contains("_Garden") &&
          (!name.contains(data[i].toString().contains("Garden")))) {
        name.add("Garden");
        pg.add("Garden");
      }
    }

    // name = name.toSet().toList();
    // pg = pg.toSet().toList();

    setState(() {
      name = name.toSet().toList();
      pg = pg.toSet().toList();
      //print("$name  88889978");
    });

    return "success";
  }



  Future<void> internet() async {
    print("the connectivity is now $result """"""""""""""""""""""""""""""""""""""""""""""""""");
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        print("the connectivity eeeeeeeeeeeeeeeeeee  is now $result """"""""""""""""""""""""""""""""""""""""""""""""""");
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
    //localData();
    // fireData();
    internet();
    // fireData();
    // Future.delayed(Duration(seconds: 2), () {
    //   initial();
    // });
    initial();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      wiFiChecker();
      // getName();
    });
    // fireData();

    super.initState();

    //print("url type: ${widget.check_url}");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            color: Color.fromRGBO(26, 28, 30, 0.6),
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: () {
                  // print(name[index].toString());
                  // print(index);
                  // print(ipAddress);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Button(
                                name[index].toString(),
                                index,
                                ipAddress,
                                g1,
                              )));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white38,
                          offset: Offset(
                            -2.5,
                            -2.5,
                          ),
                          blurRadius: 6.0,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(
                            2.5,
                            2.5,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Container(
                      height: height * 0.20,
                      width: width * 0.80,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.7), BlendMode.dstATop),
                          image: name[index].toString().contains("Hall")
                              ? AssetImage(
                                  "images/room/hall.png",
                                )
                              : name[index].toString().contains("Admin")
                                  ? AssetImage(
                                      "images/room/admin room.jpg",
                                    )
                                  : name[index].toString().contains("Garage")
                                      ? AssetImage(
                                          "images/room/garage.png",
                                        )
                                      : name[index]
                                              .toString()
                                              .contains("Kitchen")
                                          ? AssetImage(
                                              "images/room/kitchen.png",
                                            )
                                          : name[index]
                                                  .toString()
                                                  .contains("Bathroom1")
                                              ? AssetImage(
                                                  "images/room/bathroom 1.png",
                                                )
                                              : name[index]
                                                      .toString()
                                                      .contains("Bathroom2")
                                                  ? AssetImage(
                                                      "images/room/bathroom 2.png",
                                                    )
                                                  : name[index]
                                                          .toString()
                                                          .contains("Bedroom1")
                                                      ? AssetImage(
                                                          "images/room/bedroom 1.png",
                                                        )
                                                      : name[index]
                                                              .toString()
                                                              .contains(
                                                                  "Bedroom2")
                                                          ? AssetImage(
                                                              "images/room/bedroom 2.png",
                                                            )
                                                          : name[index]
                                                                  .toString()
                                                                  .contains(
                                                                      "Kids_Room")
                                                              ? AssetImage(
                                                                  "images/room/kids bedroom.png",
                                                                )
                                                              : name[index]
                                                                      .toString()
                                                                      .contains(
                                                                          "Master_Bedroom")
                                                                  ? AssetImage(
                                                                      "images/room/master bedroom.png",
                                                                    )
                                                                  : name[index]
                                                                          .toString()
                                                                          .contains(
                                                                              "Bedroom")
                                                                      ? AssetImage(
                                                                          "images/room/bedroom 2.png",
                                                                        )
                                                                      : name[index]
                                                                              .toString()
                                                                              .contains("Outside")
                                                                          ? AssetImage(
                                                                              "images/room/outside.png",
                                                                            )
                                                                          : name[index].toString().contains("Garden")
                                                                              ? AssetImage(
                                                                                  "images/room/garden.png",
                                                                                )
                                                                              : name[index].toString().contains("Parking")
                                                                                  ? AssetImage(
                                                                                      "images/room/parking.png",
                                                                                    )
                                                                                  : name[index].toString().contains("Living_Room")
                                                                                      ? AssetImage(
                                                                                          "images/room/living room.png",
                                                                                        )
                                                                                      : name[index].toString().contains("Store_Room")
                                                                                          ? AssetImage(
                                                                                              "images/room/store room.png",
                                                                                            )
                                                                                          : AssetImage(""),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: name[index].toString().contains("Hall")
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${name[index].toString().replaceAll("_", " ")}",
                                                  style: TextStyle(
                                                      fontSize: height * 0.025,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.white),
                                                ),
                                                // Text(name[index].toString()),
                                              ],
                                            ),
                                            ((name[index].toString().length) >
                                                    13)
                                                ? SizedBox(
                                                    width: width * 0.15,
                                                  )
                                                : ((name[index]
                                                            .toString()
                                                            .length) >=
                                                        9)
                                                    ? SizedBox(
                                                        width: width * 0.25,
                                                      )
                                                    : ((name[index]
                                                                .toString()
                                                                .length) <=
                                                            4)
                                                        ? SizedBox(
                                                            width:
                                                                width * 0.450,
                                                          )
                                                        : ((name[index]
                                                                    .toString()
                                                                    .length) <=
                                                                8)
                                                            ? SizedBox(
                                                                width: width *
                                                                    0.35,
                                                              )
                                                            : SizedBox(
                                                                width: width *
                                                                    0.20),
                                            // SizedBox(
                                            //   width: width*0.50,
                                            Transform.scale(
                                              scale: 1.2,
                                              child: Switch(
                                                  activeColor: Colors.orange,
                                                  thumbColor:
                                                      MaterialStateProperty.all(
                                                          Colors.orange),
                                                  value: hallStatus,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      hallStatus = value;
                                                      if (hallStatus == true) {
                                                        statusInt = 1;
                                                      } else {
                                                        statusInt = 0;
                                                      }

                                                      toggleButton(
                                                          index, statusInt);
                                                    });
                                                  }),
                                            )
                                          ],
                                        )
                                      : name[index].toString().contains("Admin")
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${name[index].toString().replaceAll("_", " ")}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              height * 0.025,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ],
                                                ),
                                                ((name[index]
                                                            .toString()
                                                            .length) >
                                                        13)
                                                    ? SizedBox(
                                                        width: width * 0.15,
                                                      )
                                                    : ((name[index]
                                                                .toString()
                                                                .length) >=
                                                            9)
                                                        ? SizedBox(
                                                            width: width * 0.25,
                                                          )
                                                        : ((name[index]
                                                                    .toString()
                                                                    .length) <=
                                                                4)
                                                            ? SizedBox(
                                                                width: width *
                                                                    0.50,
                                                              )
                                                            : ((name[index]
                                                                        .toString()
                                                                        .length) <=
                                                                    8)
                                                                ? SizedBox(
                                                                    width:
                                                                        width *
                                                                            0.35,
                                                                  )
                                                                : SizedBox(
                                                                    width: width *
                                                                        0.20),
                                                Transform.scale(
                                                  scale: 1.2,
                                                  child: Switch(
                                                      activeColor:
                                                          Colors.orange,
                                                      thumbColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .orange),
                                                      value: adminStatus,
                                                      onChanged: (bool value) {
                                                        setState(() {
                                                          adminStatus = value;
                                                          if (adminStatus ==
                                                              true) {
                                                            statusInt = 1;
                                                          } else {
                                                            statusInt = 0;
                                                          }

                                                          toggleButton(
                                                              index, statusInt);
                                                        });
                                                      }),
                                                )
                                              ],
                                            )
                                          : name[index]
                                                  .toString()
                                                  .contains("Garage")
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${name[index].toString().replaceAll("_", " ")}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: height *
                                                                  0.025,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                      ],
                                                    ),
                                                    ((name[index]
                                                                .toString()
                                                                .length) >
                                                            13)
                                                        ? SizedBox(
                                                            width: width * 0.15,
                                                          )
                                                        : ((name[index]
                                                                    .toString()
                                                                    .length) >=
                                                                9)
                                                            ? SizedBox(
                                                                width: width *
                                                                    0.25,
                                                              )
                                                            : ((name[index]
                                                                        .toString()
                                                                        .length) <=
                                                                    4)
                                                                ? SizedBox(
                                                                    width:
                                                                        width *
                                                                            0.50,
                                                                  )
                                                                : ((name[index]
                                                                            .toString()
                                                                            .length) <=
                                                                        8)
                                                                    ? SizedBox(
                                                                        width: width *
                                                                            0.35,
                                                                      )
                                                                    : SizedBox(
                                                                        width: width *
                                                                            0.20),
                                                    Transform.scale(
                                                      scale: 1.2,
                                                      child: Switch(
                                                          activeColor:
                                                              Colors.orange,
                                                          thumbColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .orange),
                                                          value: garageStatus,
                                                          onChanged:
                                                              (bool value) {
                                                            setState(() {
                                                              garageStatus =
                                                                  value;
                                                              if (garageStatus ==
                                                                  true) {
                                                                statusInt = 1;
                                                              } else {
                                                                statusInt = 0;
                                                              }

                                                              toggleButton(
                                                                  index,
                                                                  statusInt);
                                                            });
                                                          }),
                                                    )
                                                  ],
                                                )
                                              : name[index]
                                                      .toString()
                                                      .contains("Kitchen")
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${name[index].toString().replaceAll("_", " ")}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      height *
                                                                          0.025,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                            ),
                                                          ],
                                                        ),
                                                        ((name[index]
                                                                    .toString()
                                                                    .length) >
                                                                13)
                                                            ? SizedBox(
                                                                width: width *
                                                                    0.15,
                                                              )
                                                            : ((name[index]
                                                                        .toString()
                                                                        .length) >=
                                                                    9)
                                                                ? SizedBox(
                                                                    width:
                                                                        width *
                                                                            0.25,
                                                                  )
                                                                : ((name[index]
                                                                            .toString()
                                                                            .length) <=
                                                                        4)
                                                                    ? SizedBox(
                                                                        width: width *
                                                                            0.50,
                                                                      )
                                                                    : ((name[index].toString().length) <=
                                                                            8)
                                                                        ? SizedBox(
                                                                            width:
                                                                                width * 0.35,
                                                                          )
                                                                        : SizedBox(
                                                                            width:
                                                                                width * 0.20),
                                                        Transform.scale(
                                                          scale: 1.2,
                                                          child: Switch(
                                                              activeColor:
                                                                  Colors.orange,
                                                              thumbColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .orange),
                                                              value:
                                                                  kitchenStatus,
                                                              onChanged:
                                                                  (bool value) {
                                                                setState(() {
                                                                  kitchenStatus =
                                                                      value;
                                                                  if (kitchenStatus ==
                                                                      true) {
                                                                    statusInt =
                                                                        1;
                                                                  } else {
                                                                    statusInt =
                                                                        0;
                                                                  }

                                                                  toggleButton(
                                                                      index,
                                                                      statusInt);
                                                                });
                                                              }),
                                                        )
                                                      ],
                                                    )
                                                  : name[index]
                                                          .toString()
                                                          .contains("Bathroom1")
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "${name[index].toString().replaceAll("_", " ")}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          height *
                                                                              0.025,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                              ],
                                                            ),
                                                            ((name[index]
                                                                        .toString()
                                                                        .length) >
                                                                    13)
                                                                ? SizedBox(
                                                                    width:
                                                                        width *
                                                                            0.15,
                                                                  )
                                                                : ((name[index]
                                                                            .toString()
                                                                            .length) >=
                                                                        9)
                                                                    ? SizedBox(
                                                                        width: width *
                                                                            0.25,
                                                                      )
                                                                    : ((name[index].toString().length) <=
                                                                            4)
                                                                        ? SizedBox(
                                                                            width:
                                                                                width * 0.50,
                                                                          )
                                                                        : ((name[index].toString().length) <=
                                                                                8)
                                                                            ? SizedBox(
                                                                                width: width * 0.35,
                                                                              )
                                                                            : SizedBox(width: width * 0.20),
                                                            Transform.scale(
                                                              scale: 1.2,
                                                              child: Switch(
                                                                  activeColor:
                                                                      Colors
                                                                          .orange,
                                                                  thumbColor:
                                                                      MaterialStateProperty.all(
                                                                          Colors
                                                                              .orange),
                                                                  value:
                                                                      bathRoomStatus,
                                                                  onChanged: (bool
                                                                      value) {
                                                                    setState(
                                                                        () {
                                                                      bathRoomStatus =
                                                                          value;
                                                                      if (bathRoomStatus ==
                                                                          true) {
                                                                        statusInt =
                                                                            1;
                                                                      } else {
                                                                        statusInt =
                                                                            0;
                                                                      }

                                                                      toggleButton(
                                                                          index,
                                                                          statusInt);
                                                                    });
                                                                  }),
                                                            )
                                                          ],
                                                        )
                                                      : name[index]
                                                              .toString()
                                                              .contains(
                                                                  "Bathroom2")
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "${name[index].toString().replaceAll("_", " ")}",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: height *
                                                                              0.025,
                                                                          fontWeight:
                                                                              FontWeight.w900),
                                                                    ),
                                                                  ],
                                                                ),
                                                                ((name[index]
                                                                            .toString()
                                                                            .length) >
                                                                        13)
                                                                    ? SizedBox(
                                                                        width: width *
                                                                            0.15,
                                                                      )
                                                                    : ((name[index].toString().length) >=
                                                                            9)
                                                                        ? SizedBox(
                                                                            width:
                                                                                width * 0.25,
                                                                          )
                                                                        : ((name[index].toString().length) <=
                                                                                4)
                                                                            ? SizedBox(
                                                                                width: width * 0.50,
                                                                              )
                                                                            : ((name[index].toString().length) <= 8)
                                                                                ? SizedBox(
                                                                                    width: width * 0.35,
                                                                                  )
                                                                                : SizedBox(width: width * 0.20),
                                                                Transform.scale(
                                                                  scale: 1.2,
                                                                  child: Switch(
                                                                      activeColor:
                                                                          Colors
                                                                              .orange,
                                                                      thumbColor:
                                                                          MaterialStateProperty.all(Colors
                                                                              .orange),
                                                                      value:
                                                                          bathRoomStatus,
                                                                      onChanged:
                                                                          (bool
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          bathRoomStatus =
                                                                              value;
                                                                          if (bathRoomStatus ==
                                                                              true) {
                                                                            statusInt =
                                                                                1;
                                                                          } else {
                                                                            statusInt =
                                                                                0;
                                                                          }

                                                                          toggleButton(
                                                                              index,
                                                                              statusInt);
                                                                        });
                                                                      }),
                                                                )
                                                              ],
                                                            )
                                                          : name[index]
                                                                  .toString()
                                                                  .contains(
                                                                      "Bedroom1")
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "${name[index].toString().replaceAll("_", " ")}",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: height * 0.025,
                                                                              fontWeight: FontWeight.w900),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    ((name[index].toString().length) >
                                                                            13)
                                                                        ? SizedBox(
                                                                            width:
                                                                                width * 0.15,
                                                                          )
                                                                        : ((name[index].toString().length) >=
                                                                                9)
                                                                            ? SizedBox(
                                                                                width: width * 0.25,
                                                                              )
                                                                            : ((name[index].toString().length) <= 4)
                                                                                ? SizedBox(
                                                                                    width: width * 0.50,
                                                                                  )
                                                                                : ((name[index].toString().length) <= 8)
                                                                                    ? SizedBox(
                                                                                        width: width * 0.35,
                                                                                      )
                                                                                    : SizedBox(width: width * 0.20),
                                                                    Transform
                                                                        .scale(
                                                                      scale:
                                                                          1.2,
                                                                      child: Switch(
                                                                          activeColor: Colors.orange,
                                                                          thumbColor: MaterialStateProperty.all(Colors.orange),
                                                                          value: bedRoom1Status,
                                                                          onChanged: (bool value) {
                                                                            setState(() {
                                                                              bedRoom1Status = value;
                                                                              if (bedRoom1Status == true) {
                                                                                statusInt = 1;
                                                                              } else {
                                                                                statusInt = 0;
                                                                              }

                                                                              toggleButton(index, statusInt);
                                                                            });
                                                                          }),
                                                                    )
                                                                  ],
                                                                )
                                                              : name[index]
                                                                      .toString()
                                                                      .contains(
                                                                          "Bedroom2")
                                                                  ? Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "${name[index].toString().replaceAll("_", " ")}",
                                                                              style: TextStyle(color: Colors.white, fontSize: height * 0.025, fontWeight: FontWeight.w900),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        ((name[index].toString().length) >
                                                                                13)
                                                                            ? SizedBox(
                                                                                width: width * 0.15,
                                                                              )
                                                                            : ((name[index].toString().length) >= 9)
                                                                                ? SizedBox(
                                                                                    width: width * 0.25,
                                                                                  )
                                                                                : ((name[index].toString().length) <= 4)
                                                                                    ? SizedBox(
                                                                                        width: width * 0.50,
                                                                                      )
                                                                                    : ((name[index].toString().length) <= 8)
                                                                                        ? SizedBox(
                                                                                            width: width * 0.35,
                                                                                          )
                                                                                        : SizedBox(width: width * 0.20),
                                                                        Transform
                                                                            .scale(
                                                                          scale:
                                                                              1.2,
                                                                          child: Switch(
                                                                              activeColor: Colors.orange,
                                                                              thumbColor: MaterialStateProperty.all(Colors.orange),
                                                                              value: bedRoom2Status,
                                                                              onChanged: (bool value) {
                                                                                setState(() {
                                                                                  bedRoom2Status = value;
                                                                                  if (bedRoom2Status == true) {
                                                                                    statusInt = 1;
                                                                                  } else {
                                                                                    statusInt = 0;
                                                                                  }

                                                                                  toggleButton(index, statusInt);
                                                                                });
                                                                              }),
                                                                        )
                                                                      ],
                                                                    )
                                                                  : name[index]
                                                                          .toString()
                                                                          .contains(
                                                                              "Master_Bedroom")
                                                                      ? Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            Column(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  "${name[index].toString().replaceAll("_", " ")}",
                                                                                  style: TextStyle(color: Colors.white, fontSize: height * 0.025, fontWeight: FontWeight.w900),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            ((name[index].toString().length) > 13)
                                                                                ? SizedBox(
                                                                                    width: width * 0.15,
                                                                                  )
                                                                                : ((name[index].toString().length) >= 9)
                                                                                    ? SizedBox(
                                                                                        width: width * 0.25,
                                                                                      )
                                                                                    : ((name[index].toString().length) <= 4)
                                                                                        ? SizedBox(
                                                                                            width: width * 0.50,
                                                                                          )
                                                                                        : ((name[index].toString().length) <= 8)
                                                                                            ? SizedBox(
                                                                                                width: width * 0.35,
                                                                                              )
                                                                                            : SizedBox(width: width * 0.20),
                                                                            Transform.scale(
                                                                              scale: 1.2,
                                                                              child: Switch(
                                                                                  activeColor: Colors.orange,
                                                                                  thumbColor: MaterialStateProperty.all(Colors.orange),
                                                                                  value: masterBedStatus,
                                                                                  onChanged: (bool value) {
                                                                                    setState(() {
                                                                                      masterBedStatus = value;
                                                                                      if (masterBedStatus == true) {
                                                                                        statusInt = 1;
                                                                                      } else {
                                                                                        statusInt = 0;
                                                                                      }

                                                                                      toggleButton(index, statusInt);
                                                                                    });
                                                                                  }),
                                                                            )
                                                                          ],
                                                                        )
                                                                      : name[index]
                                                                              .toString()
                                                                              .contains("Bedroom")
                                                                          ? Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      "${name[index].toString().replaceAll("_", " ")}",
                                                                                      style: TextStyle(color: Colors.white, fontSize: height * 0.025, fontWeight: FontWeight.w900),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                ((name[index].toString().length) > 13)
                                                                                    ? SizedBox(
                                                                                        width: width * 0.15,
                                                                                      )
                                                                                    : ((name[index].toString().length) >= 9)
                                                                                        ? SizedBox(
                                                                                            width: width * 0.25,
                                                                                          )
                                                                                        : ((name[index].toString().length) <= 4)
                                                                                            ? SizedBox(
                                                                                                width: width * 0.450,
                                                                                              )
                                                                                            : ((name[index].toString().length) <= 8)
                                                                                                ? SizedBox(
                                                                                                    width: width * 0.32,
                                                                                                  )
                                                                                                : SizedBox(width: width * 0.20),
                                                                                Transform.scale(
                                                                                  scale: 1.2,
                                                                                  child: Switch(
                                                                                      activeColor: Colors.orange,
                                                                                      thumbColor: MaterialStateProperty.all(Colors.orange),
                                                                                      value: bedRoomStatus,
                                                                                      onChanged: (bool value) {
                                                                                        setState(() {
                                                                                          bedRoomStatus = value;
                                                                                          if (bedRoomStatus == true) {
                                                                                            statusInt = 1;
                                                                                          } else {
                                                                                            statusInt = 0;
                                                                                          }

                                                                                          toggleButton(index, statusInt);
                                                                                        });
                                                                                      }),
                                                                                )
                                                                              ],
                                                                            )
                                                                          : name[index].toString().contains("Outside")
                                                                              ? Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          "${name[index].toString().replaceAll("_", " ")}",
                                                                                          style: TextStyle(color: Colors.white, fontSize: height * 0.025, fontWeight: FontWeight.w900),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    ((name[index].toString().length) > 13)
                                                                                        ? SizedBox(
                                                                                            width: width * 0.15,
                                                                                          )
                                                                                        : ((name[index].toString().length) >= 9)
                                                                                            ? SizedBox(
                                                                                                width: width * 0.25,
                                                                                              )
                                                                                            : ((name[index].toString().length) <= 4)
                                                                                                ? SizedBox(
                                                                                                    width: width * 0.450,
                                                                                                  )
                                                                                                : ((name[index].toString().length) <= 8)
                                                                                                    ? SizedBox(
                                                                                                        width: width * 0.32,
                                                                                                      )
                                                                                                    : SizedBox(width: width * 0.20),
                                                                                    Transform.scale(
                                                                                      scale: 1.2,
                                                                                      child: Switch(
                                                                                          activeColor: Colors.orange,
                                                                                          thumbColor: MaterialStateProperty.all(Colors.orange),
                                                                                          value: outSideStatus,
                                                                                          onChanged: (bool value) {
                                                                                            setState(() {
                                                                                              outSideStatus = value;
                                                                                              if (outSideStatus == true) {
                                                                                                statusInt = 1;
                                                                                              } else {
                                                                                                statusInt = 0;
                                                                                              }

                                                                                              toggleButton(index, statusInt);
                                                                                            });
                                                                                          }),
                                                                                    )
                                                                                  ],
                                                                                )
                                                                              : name[index].toString().contains("Garden")
                                                                                  ? Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      children: [
                                                                                        Column(
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              "${name[index].toString().replaceAll("_", " ")}",
                                                                                              style: TextStyle(color: Colors.white, fontSize: height * 0.025, fontWeight: FontWeight.w900),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        ((name[index].toString().length) > 13)
                                                                                            ? SizedBox(
                                                                                                width: width * 0.15,
                                                                                              )
                                                                                            : ((name[index].toString().length) >= 9)
                                                                                                ? SizedBox(
                                                                                                    width: width * 0.25,
                                                                                                  )
                                                                                                : ((name[index].toString().length) <= 4)
                                                                                                    ? SizedBox(
                                                                                                        width: width * 0.450,
                                                                                                      )
                                                                                                    : ((name[index].toString().length) <= 8)
                                                                                                        ? SizedBox(
                                                                                                            width: width * 0.32,
                                                                                                          )
                                                                                                        : SizedBox(width: width * 0.20),
                                                                                        Transform.scale(
                                                                                          scale: 1.2,
                                                                                          child: Switch(
                                                                                              activeColor: Colors.orange,
                                                                                              thumbColor: MaterialStateProperty.all(Colors.orange),
                                                                                              value: gardenStatus,
                                                                                              onChanged: (bool value) {
                                                                                                setState(() {
                                                                                                  gardenStatus = value;
                                                                                                  if (gardenStatus == true) {
                                                                                                    statusInt = 1;
                                                                                                  } else {
                                                                                                    statusInt = 0;
                                                                                                  }

                                                                                                  toggleButton(index, statusInt);
                                                                                                });
                                                                                              }),
                                                                                        )
                                                                                      ],
                                                                                    )
                                                                                  : name[index].toString().contains("Parking")
                                                                                      ? Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                          children: [
                                                                                            Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Text(
                                                                                                  "${name[index].toString().replaceAll("_", " ")}",
                                                                                                  style: TextStyle(color: Colors.white, fontSize: height * 0.025, fontWeight: FontWeight.w900),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            ((name[index].toString().length) > 13)
                                                                                                ? SizedBox(
                                                                                                    width: width * 0.15,
                                                                                                  )
                                                                                                : ((name[index].toString().length) >= 9)
                                                                                                    ? SizedBox(
                                                                                                        width: width * 0.25,
                                                                                                      )
                                                                                                    : ((name[index].toString().length) <= 4)
                                                                                                        ? SizedBox(
                                                                                                            width: width * 0.450,
                                                                                                          )
                                                                                                        : ((name[index].toString().length) <= 8)
                                                                                                            ? SizedBox(
                                                                                                                width: width * 0.32,
                                                                                                              )
                                                                                                            : SizedBox(width: width * 0.20),
                                                                                            Transform.scale(
                                                                                              scale: 1.2,
                                                                                              child: Switch(
                                                                                                  activeColor: Colors.orange,
                                                                                                  thumbColor: MaterialStateProperty.all(Colors.orange),
                                                                                                  value: parkingStatus,
                                                                                                  onChanged: (bool value) {
                                                                                                    setState(() {
                                                                                                      parkingStatus = value;
                                                                                                      if (parkingStatus == true) {
                                                                                                        statusInt = 1;
                                                                                                      } else {
                                                                                                        statusInt = 0;
                                                                                                      }

                                                                                                      toggleButton(index, statusInt);
                                                                                                    });
                                                                                                  }),
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                      : name[index].toString().contains("Living_Room")
                                                                                          ? Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                              children: [
                                                                                                Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      "${name[index].toString().replaceAll("_", " ")}",
                                                                                                      style: TextStyle(color: Colors.white, fontSize: height * 0.025, fontWeight: FontWeight.w900),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                ((name[index].toString().length) > 13)
                                                                                                    ? SizedBox(
                                                                                                        width: width * 0.15,
                                                                                                      )
                                                                                                    : ((name[index].toString().length) >= 9)
                                                                                                        ? SizedBox(
                                                                                                            width: width * 0.25,
                                                                                                          )
                                                                                                        : ((name[index].toString().length) <= 4)
                                                                                                            ? SizedBox(
                                                                                                                width: width * 0.45,
                                                                                                              )
                                                                                                            : ((name[index].toString().length) <= 8)
                                                                                                                ? SizedBox(
                                                                                                                    width: width * 0.32,
                                                                                                                  )
                                                                                                                : SizedBox(width: width * 0.20),
                                                                                                Transform.scale(
                                                                                                  scale: 1.2,
                                                                                                  child: Switch(
                                                                                                      activeColor: Colors.orange,
                                                                                                      thumbColor: MaterialStateProperty.all(Colors.orange),
                                                                                                      value: livingStatus,
                                                                                                      onChanged: (bool value) {
                                                                                                        setState(() {
                                                                                                          livingStatus = value;
                                                                                                          if (livingStatus == true) {
                                                                                                            statusInt = 1;
                                                                                                          } else {
                                                                                                            statusInt = 0;
                                                                                                          }

                                                                                                          toggleButton(index, statusInt);
                                                                                                        });
                                                                                                      }),
                                                                                                )
                                                                                              ],
                                                                                            )
                                                                                          : name[index].toString().contains("Store_Room")
                                                                                              ? Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                  children: [
                                                                                                    Column(
                                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          "${name[index].toString().replaceAll("_", " ")}",
                                                                                                          style: TextStyle(color: Colors.white, fontSize: height * 0.025, fontWeight: FontWeight.w900),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    ((name[index].toString().length) > 13)
                                                                                                        ? SizedBox(
                                                                                                            width: width * 0.15,
                                                                                                          )
                                                                                                        : ((name[index].toString().length) >= 9)
                                                                                                            ? SizedBox(
                                                                                                                width: width * 0.25,
                                                                                                              )
                                                                                                            : ((name[index].toString().length) <= 4)
                                                                                                                ? SizedBox(
                                                                                                                    width: width * 0.45,
                                                                                                                  )
                                                                                                                : ((name[index].toString().length) <= 8)
                                                                                                                    ? SizedBox(
                                                                                                                        width: width * 0.32,
                                                                                                                      )
                                                                                                                    : SizedBox(width: width * 0.20),
                                                                                                    Transform.scale(
                                                                                                      scale: 1.2,
                                                                                                      child: Switch(
                                                                                                          activeColor: Colors.orange,
                                                                                                          thumbColor: MaterialStateProperty.all(Colors.orange),
                                                                                                          value: storeStatus,
                                                                                                          onChanged: (bool value) {
                                                                                                            setState(() {
                                                                                                              storeStatus = value;
                                                                                                              if (storeStatus == true) {
                                                                                                                statusInt = 1;
                                                                                                              } else {
                                                                                                                statusInt = 0;
                                                                                                              }

                                                                                                              toggleButton(index, statusInt);
                                                                                                            });
                                                                                                          }),
                                                                                                    )
                                                                                                  ],
                                                                                                )
                                                                                              : Container(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        childCount: name.length,
      ),
    );
  }

  showWifiNetAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("ok"),
      onPressed: (){
        notifier = false;
        mobNotifier = false;
        wifiNotifier = false;
        initial();
        wiFiChecker();
        Navigator.pop(context, false);
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text("  Connect WiFi ",style: TextStyle(color: Colors.white60,fontWeight: FontWeight.bold),),
      content: Text("please connect your device with WiFi Internet by list ",style: TextStyle(color: Colors.white60),),
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
  showAnotherAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("ok"),
      onPressed: (){
        notifier = false;
        mobNotifier = false;
        wifiNotifier = false;
        wiFiChecker();
        Navigator.pop(context, false);
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text("  No Internet ",style: TextStyle(color: Colors.white60,fontWeight: FontWeight.bold),),
      content: Text("please connect your device with INTERNET for app installation ",style: TextStyle(color: Colors.white60),),
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
