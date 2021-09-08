
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:onwords_home/firstPage/individual_page.dart';
import 'package:overlay_support/overlay_support.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';



FirebaseAuth auth = FirebaseAuth.instance;
final databaseReference = FirebaseDatabase.instance.reference();

class FirstPage extends StatefulWidget {

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with AutomaticKeepAliveClientMixin {

  SharedPreferences logindata;
  String username;
  bool notifier = false;
  bool mobNotifier = false;
  Gradient g1 = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.grey[800],
        Colors.grey[800],
      ]);


  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  }


  String userName = " ";
  String ipAddress;

  Future <String> getData(){

    databaseReference.child(auth.currentUser.uid).once().then((DataSnapshot snapshot) {

      // print('Data : ${snapshot.value}');
      // print("iam going to map ");
      var dataJson=snapshot.value;
      // print("dataJson = $dataJson");
      // print(dataJson["name"]);
      setState(() {

        userName = dataJson["name"];
        ipAddress= dataJson["ip"];

        // print("$ipAddress --------");
      });



      // if(data == null){
      //   print("inside the data values is $data");
      //   showAnotherAlertDialog(context);
      // }

      if(result == ConnectivityResult.wifi) {
        //print("wifi =============_________(((((((((()))))))");
        get_name();
      }
      else if((result == ConnectivityResult.mobile)&&(!mobNotifier)){
        //print("mobile ****************************");
        if(!mobNotifier){
          showSimpleNotification(
            Text(" please switch on your wifi network ",
              style: TextStyle(color: Colors.white),), background: Colors.red,
          );
        }
        mobNotifier = true;
      }
      else if((result == ConnectivityResult.none)&&(!notifier))
      {
        // print(" ************** none **************");
        // print("$notifier the value of the notifier is 00000000");
        if(!notifier){
          // print(" im inside the if notifier class");
          showSimpleNotification(
            Text(" No Internet Connectivity ",
              style: TextStyle(color: Colors.white),), background: Colors.red,
          );
        }
        notifier = true;
      }

    });
  }




  bool currentIndex = false;
  bool _pinned = true;
  bool _floating = false;

  bool valueStatus = false;
  List name = [];
  List pg = [];
  List data;
  bool first;

  Future get_name() async {

    final response = await http.get(Uri.parse("http://$ipAddress/key",));

    var fetchdata = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        data = fetchdata;

      });

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
        } else if (data[i].toString().contains("_Bedroom") &&
            (!name.contains(data[i].toString().contains("Bedroom")))) {
          name.add("Bedroom");
          pg.add("Bedroom");
        } else if (data[i].toString().contains("_Bedroom1") &&
            (!name.contains(data[i].toString().contains("Bedroom_1")))) {
          name.add("Bedroom_1");
          pg.add("Bedroom_1");
        } else if (data[i].toString().contains("_Bedroom2") &&
            (!name.contains(data[i].toString().contains("Bedroom_2")))) {
          name.add("Bedroom_2");
          pg.add("Bedroom_2");
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
    }

    setState(() {
      name = name.toSet().toList();
      pg = pg.toSet().toList();
      print(name);
    });
    return "success";
  }


  Timer timer;
  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;

  Future<void> internet() async {
    hasInternet = await InternetConnectionChecker().hasConnection;
    result = await Connectivity().checkConnectivity();
  }

  @override
  void initState() {
    initial();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      getData();
    });

    internet();
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
    super.initState();

    //print("url type: ${widget.check_url}");
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
    return SafeArea(
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
                        " Nikhil ",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w300, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  // color: Color.fromRGBO(40, 36, 36, 1.0),
                  color: Color.fromRGBO(26, 28, 30, 0.6),
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Container(
                      height: height * 0.10,
                      width: width * 0.80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color.fromRGBO(247, 179, 28,1.0),
                            Color.fromRGBO(255, 210, 112,1.0),
                          ],
                          stops: [0.1,0.7],
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white38,
                            offset: Offset(
                              -2.5,
                              -0.5,
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Partially cloudy"),
                                Text(
                                  "32°C",
                                  style: GoogleFonts.montserrat(
                                    fontSize: height*0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Image(
                              image: AssetImage("images/cloud.png"),
                              height: height * 0.085,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      color: Color.fromRGBO(26, 28, 30, 0.6),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Button(name[index].toString(),index,ipAddress,g1,)));
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>IndividualPage(imgValue: widget.choice.backGroundImage,txtValue: widget.choice.title,)));
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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
                                    image: name[index]
                                        .toString()
                                        .contains("Hall")
                                        ? AssetImage(
                                      "images/fur.jpg",
                                    )
                                        : name[index]
                                        .toString()
                                        .contains("Admin")
                                        ? AssetImage(
                                      "images/fur.jpg",
                                    )
                                        : name[index]
                                        .toString()
                                        .contains(
                                        "Garage")
                                        ? AssetImage(
                                      "images/guest.png",
                                    )
                                        : name[index]
                                        .toString()
                                        .contains(
                                        "Kitchen")
                                        ? AssetImage(
                                      "images/kitchen.png",
                                    )
                                        : name[index]
                                        .toString()
                                        .contains(
                                        "Bathroom")
                                        ? AssetImage(
                                      "images/bathroom.png",
                                    )
                                        : name[index]
                                        .toString()
                                        .contains(
                                        "Bedroom_1")
                                        ? AssetImage(
                                      "images/bedroom.png",
                                    )
                                        : name[index].toString().contains("Bedroom_2")
                                        ? AssetImage(
                                      "images/bedroom.png",
                                    )
                                        : name[index].toString().contains("Master_Bedroom")
                                        ? AssetImage(
                                      "images/bedroom.png",
                                    )
                                        : name[index].toString().contains("Bedroom")
                                        ? AssetImage(
                                      "images/bedroom.png",
                                    )
                                        : name[index].toString().contains("Outside")
                                        ? AssetImage(
                                      "images/fur.jpg",
                                    )
                                        : name[index].toString().contains("Garden")
                                        ? AssetImage(
                                      "images/fur.jpg",
                                    )
                                        : name[index].toString().contains("Parking")
                                        ? AssetImage(
                                      "images/fur.jpg",
                                    )
                                        : name[index].toString().contains("Living_Room")
                                        ? AssetImage(
                                      "images/fur.jpg",

                                    )
                                        : name[index].toString().contains("Store_Room")
                                        ? AssetImage(
                                      "images/fur.jpg",
                                    )
                                        : AssetImage(""),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            child: name[index]
                                                .toString()
                                                .contains("Hall")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),

                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(width: width*0.080,),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index]
                                                .toString()
                                                .contains("Admin")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width *
                                                          0.2,
                                                      height:
                                                      height *
                                                          0.1,
                                                    ),
                                                    AutoSizeText(name[index].toString(),style: TextStyle(fontSize: height*0.013),),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width: width*0.080,),
                                                Switch(
                                                    activeColor:
                                                    Colors
                                                        .orange,
                                                    thumbColor:
                                                    MaterialStateProperty.all(
                                                        Colors
                                                            .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged: (bool
                                                    value) {
                                                      setState(
                                                              () {
                                                            valueStatus =
                                                                value;
                                                          });
                                                    })
                                              ],
                                            )
                                                : name[index]
                                                .toString()
                                                .contains(
                                                "Garage")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width: width*0.080,),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index]
                                                .toString()
                                                .contains(
                                                "Kitchen")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(width: width*0.080,),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index]
                                                .toString()
                                                .contains(
                                                "Bathroom")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(width: width*0.080,),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index]
                                                .toString()
                                                .contains(
                                                "Bedroom_1")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(width: width*0.080,),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Bedroom_2")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(width: width*0.080,),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Master_Bedroom")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    AutoSizeText(name[index].toString(),style: TextStyle(fontSize: height*0.013),),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(width: width*0.030,),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Bedroom")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(width: width*0.080,),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Outside")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(width: width*0.080,),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Garden")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(width: width*0.080,),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Parking")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(width: width*0.080,),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Living_Room")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(width: width*0.080,),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Store_Room")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(width: width*0.080,),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
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
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400.0,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: 1.0,
                ),
              ):
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      color: Color.fromRGBO(26, 28, 30, 0.6),
                      child: Padding(
                        padding: EdgeInsets.all(18.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Button(name[index].toString(),index,ipAddress,g1,)));
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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
                                    image: name[index]
                                        .toString()
                                        .contains("Hall")
                                        ? AssetImage(
                                      "images/fur.jpg",
                                    )
                                        : name[index]
                                        .toString()
                                        .contains("Admin")
                                        ? AssetImage(
                                      "images/fur.jpg",
                                    )
                                        : name[index]
                                        .toString()
                                        .contains(
                                        "Garage")
                                        ? AssetImage(
                                      "images/guest.png",
                                    )
                                        : name[index]
                                        .toString()
                                        .contains(
                                        "Kitchen")
                                        ? AssetImage(
                                      "images/kitchen.png",
                                    )
                                        : name[index]
                                        .toString()
                                        .contains(
                                        "Bathroom")
                                        ? AssetImage(
                                      "images/bathroom.png",
                                    )
                                        : name[index]
                                        .toString()
                                        .contains(
                                        "Bedroom_1")
                                        ? AssetImage(
                                      "images/bedroom.png",
                                    )
                                        : name[index].toString().contains("Bedroom_2")
                                        ? AssetImage(
                                      "images/bedroom.png",
                                    )
                                        : name[index].toString().contains("Master_Bedroom")
                                        ? AssetImage(
                                      "images/bedroom.png",
                                    )
                                        : name[index].toString().contains("Bedroom")
                                        ? AssetImage(
                                      "images/bedroom.png",
                                    )
                                        : name[index].toString().contains("Outside")
                                        ? AssetImage(
                                      "images/fur.jpg",
                                    )
                                        : name[index].toString().contains("Garden")
                                        ? AssetImage(
                                      "images/fur.jpg",
                                    )
                                        : name[index].toString().contains("Parking")
                                        ? AssetImage(
                                      "images/fur.jpg",
                                    )
                                        : name[index].toString().contains("Living_Room")
                                        ? AssetImage(
                                      "images/fur.jpg",

                                    )
                                        : name[index].toString().contains("Store_Room")
                                        ? AssetImage(
                                      "images/fur.jpg",
                                    )
                                        : AssetImage(""),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(1),
                                            child: name[index]
                                                .toString()
                                                .contains("Hall")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    AutoSizeText(name[index].toString(),),
                                                    // Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: width*0.50,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index]
                                                .toString()
                                                .contains("Admin")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width *
                                                          0.2,
                                                      height:
                                                      height *
                                                          0.1,
                                                    ),
                                                    AutoSizeText(name[index].toString(),
                                                    ),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: width*0.50,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors
                                                        .orange,
                                                    thumbColor:
                                                    MaterialStateProperty.all(
                                                        Colors
                                                            .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged: (bool
                                                    value) {
                                                      setState(
                                                              () {
                                                            valueStatus =
                                                                value;
                                                          });
                                                    })
                                              ],
                                            )
                                                : name[index]
                                                .toString()
                                                .contains(
                                                "Garage")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(
                                                  width: width*0.50,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index]
                                                .toString()
                                                .contains(
                                                "Kitchen")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(
                                                  width: width*0.50,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index]
                                                .toString()
                                                .contains(
                                                "Bathroom")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(
                                                  width: width*0.50,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index]
                                                .toString()
                                                .contains(
                                                "Bedroom_1")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(
                                                  width: width*0.50,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Bedroom_2")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(
                                                  width: width*0.50,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Master_Bedroom")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(
                                                  width: width*0.40,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Bedroom")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(
                                                  width: width*0.50,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Outside")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(
                                                  width: width*0.50,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Garden")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(
                                                  width: width*0.50,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Parking")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(
                                                  width: width*0.50,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Living_Room")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(
                                                  width: width*0.50,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
                                              ],
                                            )
                                                : name[index].toString().contains("Store_Room")
                                                ? Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Image.asset(
                                                      "images/chair.png",
                                                      width:
                                                      width * 0.2,
                                                      height: height *
                                                          0.1,
                                                    ),
                                                    Text(name[index].toString()),
                                                    Text(
                                                      "6 devices",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          fontSize:
                                                          height *
                                                              0.012),
                                                    )
                                                  ],
                                                ),SizedBox(
                                                  width: width*0.50,
                                                ),
                                                Switch(
                                                    activeColor:
                                                    Colors.orange,
                                                    thumbColor:
                                                    MaterialStateProperty
                                                        .all(Colors
                                                        .orange),
                                                    value:
                                                    valueStatus,
                                                    onChanged:
                                                        (bool value) {
                                                      setState(() {
                                                        valueStatus =
                                                            value;
                                                      });
                                                    })
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  showAnotherAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("ok"),
      onPressed: (){
        Navigator.pop(context, false);
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text("Oops!!!! ",style: TextStyle(color: Colors.white60,fontWeight: FontWeight.bold),),
      content: Text(" please connect your device with home wifi network  ",style: TextStyle(color: Colors.white60),),
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
