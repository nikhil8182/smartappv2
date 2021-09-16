// import 'dart:async';
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class IndividualPage extends StatefulWidget {
//   IndividualPage({this.imgValue, this.txtValue});
//   final String imgValue;
//   final String txtValue;
//
//   @override
//   _IndividualPageState createState() => _IndividualPageState();
// }
//
// var data;
//
// bool data1 = false;
// bool tubeLight = false;
// bool tubeLight2 = false;
// var rating;
// double fan = 0.0;
// var roundRat;
// bool  wallFan1 = false;
// bool  wallFan2 = false;
// bool  tFan1 = false;
// bool bBulb = false;
//
// class _IndividualPageState extends State<IndividualPage> {
//   List val = [];
//   Timer timer;
//
//
//   Future<dynamic> getData() async {
//     http.Response response =
//         await http.get(Uri.parse('http://192.168.1.18:8000/'));
//     Map data = json.decode(response.body);
//
//     setState(() {
//       int fan1 = data['Fan_Slide_Admin_Room'];
//       fan = fan1.roundToDouble();
//       data1 = data['Nfc1'];
//       tubeLight = data['Tube_Light_1_Button_Admin_Room'];
//       tubeLight2 = data['Tube_Light_2_Button_Admin_Room'];
//       wallFan1 = data['Wall_Mount_Fan_1_Push_Admin_Room'];
//       wallFan2 = data['Wall_Mount_Fan_2_Push_Admin_Room'];
//       tFan1 = data['Tower_Fan_Push_Admin_Room'];
//       bBulb = data['Bulb_Button_Admin_Room'];
//     });
//
//   }
//
//   @override
//   void initState() {
//     timer = Timer.periodic(Duration(seconds: 1),(timer)=>getData());
//     super.initState();
//   }
//
//
//   bool value = false;
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     getData();
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           height: height * 1.0,
//           width: width * 1.0,
//           child: Stack(children: [
//             Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                           begin: Alignment.bottomLeft,
//                           end: Alignment.topRight,
//                           colors: [
//                         Color.fromRGBO(0, 0, 0, 1.0),
//                         Color.fromRGBO(38, 42, 45, 1.0),
//                       ],
//                           stops: [
//                         0.1,
//                         0.9
//                       ])),
//                   child: Container(
//                     height: height * 0.55,
//                     width: width * 1.0,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             colorFilter: ColorFilter.mode(
//                                 Colors.black.withOpacity(0.7),
//                                 BlendMode.dstATop),
//                             image: AssetImage(widget.imgValue),
//                             fit: BoxFit.fill)),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 40.0),
//                   height: height * 0.45,
//                   width: width * 1.0,
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                           begin: Alignment.bottomLeft,
//                           end: Alignment.topRight,
//                           colors: [
//                         Color.fromRGBO(0, 0, 0, 1.0),
//                         Color.fromRGBO(45, 47, 49, 1.0),
//                       ],
//                           stops: [
//                         0.1,
//                         0.7
//                       ])),
//                   // child: GridView.count(
//                   //       scrollDirection: Axis.vertical,
//                   //         crossAxisCount: 2,
//                   //         crossAxisSpacing: 19.0,
//                   //         mainAxisSpacing: 12.0,
//                   //         children: List.generate(choices.length, (index) {
//                   //           return  SelectCard(choice: choices[index]);
//                   //         }
//                   //         )
//                   //     ),
//                 ),
//               ],
//               // ),
//               // Positioned(
//               //  top: height*0.35,
//               //   child: Container(
//               //     child: Column(
//               //       children: [
//               //         Text(
//               //           "Living Room",style: GoogleFonts.inter(
//               //           color: Colors.white,
//               //           fontWeight: FontWeight.bold,
//               //         ),
//               //         ),
//               //         GridView.count(
//               //             crossAxisCount: 3,
//               //             crossAxisSpacing: 4.0,
//               //             mainAxisSpacing: 8.0,
//               //             children: List.generate(choices.length, (index) {
//               //               return Center(
//               //                 child: SelectCard(choice: choices[index]),
//               //               );
//               //             }
//               //             )
//               //         )
//               //       ],
//               //     ),
//               //   ),
//               // )
//             ),
//             Positioned(
//               top: height * 0.30,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 12.0),
//                     child: Text(
//                       widget.txtValue,
//                       style: GoogleFonts.inter(
//                         fontSize: height * 0.042,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(
//                     height: height * 0.001,
//                   ),
//
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 40.0),
//                     height: height * 0.60,
//                     width: width * 1.0,
//                     color: Colors.transparent,
//                     // decoration: BoxDecoration(
//                     //     gradient: LinearGradient(
//                     //         begin: Alignment.bottomLeft,
//                     //         end: Alignment.topRight,
//                     //         colors: [
//                     //           Color.fromRGBO(0, 0, 0, 1.0),
//                     //           Color.fromRGBO(45, 47, 49, 1.0),
//                     //         ],
//                     //         stops: [
//                     //           0.1,
//                     //           0.7
//                     //         ])),
//                     child: GridView.count(
//                         scrollDirection: Axis.vertical,
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 19.0,
//                         mainAxisSpacing: 16.0,
//                         children: List.generate(choices.length, (index) {
//                           return SelectCard(choice: choices[index]);
//                         })),
//                   ),
//
//                 ],
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
//
// class Choice {
//   const Choice({this.title, this.image, this.url});
//   final String title;
//   final String image;
//   final String url;
// }
//
// const List<Choice> choices = const <Choice>[
//   const Choice(title: 'Light', image: "images/light.svg", url: "bBulb"),
//   const Choice(title: 'Light', image: "images/light.svg", url: "tubeLight"),
//   const Choice(title: 'Light', image: "images/light.svg", url: "tubeLight2"),
//   const Choice(title: 'Fan', image: "images/ac.svg", url: "wallFan1"),
//   const Choice(title: 'Fan', image: "images/ac.svg", url: "wallFan2"),
//   // const Choice(title: 'Fan', image: "images/ac.svg", url: "tFan1"),
// ];
//
// class SelectCard extends StatefulWidget {
//   const SelectCard({Key key, this.choice}) : super(key: key);
//   final Choice choice;
//
//   @override
//   _SelectCardState createState() => _SelectCardState();
// }
//
// class _SelectCardState extends State<SelectCard> {
//   bool value = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(40.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.white38,
//             offset: Offset(
//               -2.5,
//               -2.5,
//             ),
//             blurRadius: 6.0,
//             spreadRadius: 1.0,
//           ),
//           BoxShadow(
//             color: Colors.black,
//             offset: Offset(
//               2.5,
//               2.5,
//             ),
//             blurRadius: 10.0,
//             spreadRadius: 1.0,
//           ),
//         ],
//       ),
//       child: GestureDetector(
//         onTap: () async {
//           print("pressedd+++++");
//           setState(() {
//             value = !value;
//           });
//
//           if ((widget.choice.url) == "bBulb") {
//             bBulb
//                 ? await http.get(Uri.parse(
//                 'http://192.168.1.18:8000/Bulb_Button_Admin_Room/0/'))
//                 : await http.get(Uri.parse(
//                 'http://192.168.1.18:8000/Bulb_Button_Admin_Room/1/'));
//             setState(() {
//               bBulb = !bBulb;
//             });
//           }
//           if ((widget.choice.url).toString() == "tubeLight") {
//             print("im inside ${widget.choice.url}");
//             tubeLight
//                 ? await http.get(Uri.parse(
//                     'http://192.168.1.18:8000/Tube_Light_1_Button_Admin_Room/0/'))
//                 : await http.get(Uri.parse(
//                     'http://192.168.1.18:8000/Tube_Light_1_Button_Admin_Room/1/'));
//             setState(() {
//               tubeLight = !tubeLight;
//             });
//
//             // if(tubeLight){
//             //   print("im turning off the light");
//             //   await http.get(Uri.parse(
//             //             'http://192.168.1.18:8000/Tube_Light_1_Button_Admin_Room/1/'));
//             //   setState(() {
//             //     tubeLight = false;
//             //   });
//             // }
//             // else{
//             //   print("im turning ON the light");
//             //   await http.get(Uri.parse(
//             //       'http://192.168.1.18:8000/Tube_Light_1_Button_Admin_Room/0/'));
//             //   setState(() {
//             //     tubeLight = true;
//             //   });
//             // }
//           }
//
//           if ((widget.choice.url) == "tubeLight2") {
//             tubeLight2
//                 ? await http.get(Uri.parse(
//                     'http://192.168.1.18:8000/Tube_Light_2_Button_Admin_Room/0/'))
//                 : await http.get(Uri.parse(
//                     'http://192.168.1.18:8000/Tube_Light_2_Button_Admin_Room/1/'));
//             setState(() {
//               tubeLight2 = !tubeLight2;
//             });
//           }
//           if ((widget.choice.url) == "wallFan1") {
//             wallFan1
//                 ? await http.get(Uri.parse(
//                 'http://192.168.1.18:8000/Wall_Mount_Fan_1_Push_Admin_Room/0/'))
//                 : await http.get(Uri.parse(
//                 'http://192.168.1.18:8000/Wall_Mount_Fan_1_Push_Admin_Room/1/'));
//             setState(() {
//               wallFan1 = !wallFan1;
//             });
//           }
//           if ((widget.choice.url) == "wallFan2") {
//             wallFan2
//                 ? await http.get(Uri.parse(
//                 'http://192.168.1.18:8000/Wall_Mount_Fan_2_Push_Admin_Room/0/'))
//                 : await http.get(Uri.parse(
//                 'http://192.168.1.18:8000/Wall_Mount_Fan_2_Push_Admin_Room/1/'));
//             setState(() {
//               wallFan2 = !wallFan2;
//             });
//           }
//
//         },
//         child: Container(
//           height: height * 0.17,
//           width: width * 0.33,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20.0),
//             color: value
//                 ? Color.fromRGBO(247, 179, 28, 1.0)
//                 : Color.fromRGBO(39, 39, 40, 1.0),
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.end,
//                 //   children: [
//                 //     Transform.scale(
//                 //       scale: 1.3,
//                 //       child: Switch(
//                 //           activeColor: Colors.white,
//                 //           thumbColor: MaterialStateProperty.all(Colors.white),
//                 //           value: data1,
//                 //           onChanged: (bool newValue) {
//                 //             setState(() async {
//                 //               data1
//                 //                   ? await http.get(Uri.parse(
//                 //                       'http://192.168.1.18:8000/Nfc1/0/'))
//                 //                   : await http.get(Uri.parse(
//                 //                       'http://192.168.1.18:8000/Nfc1/1/'));
//                 //             });
//                 //           }),
//                 //     ),
//                 //   ],
//                 // ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SvgPicture.asset(
//                           widget.choice.image,
//                           height: height * 0.051,
//                         ),
//                         SizedBox(
//                           height: height * 0.010,
//                         ),
//                         Text(
//                           widget.choice.title,
//                           style: GoogleFonts.inter(fontSize: height * 0.021),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';




class Button extends StatefulWidget {

  String place;
  int ind;
  String ipAddress;
  Gradient g1;
  Button(this.place, this.ind, this.ipAddress, this.g1);

  @override
  _ButtonState createState() => _ButtonState();
}
int globalIndex ;

class _ButtonState extends State<Button> {

  List data;
  List name = [];
  List pg = [];
  bool check;
  String local_ip;
  String ip;

  SharedPreferences loginData;


  Future get_name() async {
    loginData = await SharedPreferences.getInstance();
    local_ip = widget.ipAddress;
    print("$local_ip ========");

    loginData.setString('ip', local_ip);

      setState(() {
        ip = loginData.getString('ip');
        print("$ip --------------");
      }
      );


    final response = await http.get(Uri.http('$ip', "/key"));

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
      // print(name);
    });
    return "success";
  }

  @override
  void initState() {

    get_name();
    // print("email ${widget.email} place ${widget.place} ind ${widget.ind} ");
    super.initState();
    // print("final url check $check");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: PageView.builder(
            itemCount: pg.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Pages(name[widget.ind].toString(), widget.g1,widget.ind,ip);
              } else if (index == widget.ind) {
                return Pages(name[0].toString(), widget.g1,widget.ind,ip);
              } else {
                return Pages(name[index].toString(), widget.g1,widget.ind,ip);
              }
            }),
      ),
    );
  }
}

class Pages extends StatefulWidget {
  String room_name;
  int index;
  Gradient g1;
  String local_ip;
  Pages(this.room_name, this.g1,this.index,this.local_ip);
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> with WidgetsBindingObserver {
  List<Widget> _buildButtonsWithNames() {
    buttonsList.clear();
    for (int i = 0; i < data.length; i++) {
      button(i);
    }
    setState(() {
      buttonsList = buttonsList.toSet().toList();
    });
    return buttonsList;
  }

  String up;
  void button(int i) {
    if (data[i].toString().contains("Button") &&
        data[i].toString().contains(widget.room_name)) {
      buttonsList.add(Container(
        child: InkWell(
            onTap: () {
              check().then((intenet) {
                if (intenet) {
                  // Internet Present Case
                  if ((data_value[0][i] == 1) || (data_value[0][i] == "1")) {
                    setState(() {
                      data_value[0][i] = 0;
                      up = "False";
                    });
                  } else {
                    setState(() {
                      data_value[0][i] = 1;
                      up = "True";
                    });
                  }
                  setState(() {
                    // if(widget.check_url==false){
                    //   update_value(data[i],data_value[0][i], i);
                    // }else{
                    //   update_value(data[i],up, i);
                    // }
                    update_value(data[i],up, i);
                    print("${data_value[0][i]} data value is =================");
                    print("$up the value of up is *************");
                    print("$i after i is+++++++++++++++++------");
                    _buildButtonsWithNames();
                  });
                  //print("Connection: present");
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: Colors.black,
                        title: Text(
                          "No Internet Connection",
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Text(
                            "Please check your Internet Connection",
                            style: TextStyle(color: Colors.white)),
                      ));
                  //print("Connection: not present");
                }
              });
            },
            child: Container(
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width * 0.37,
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: (data_value[0][i] == 0) || (data_value[0][i] == "0")? Colors.grey[900]:Colors.orange,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          color: Colors.grey[700],
                          blurRadius: 1,
                          spreadRadius: 1),
                      BoxShadow(
                          offset: Offset(1, 1),
                          color: Colors.black87,
                          blurRadius: 1,
                          spreadRadius: 1)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child:
                      SvgPicture.asset(
                        "images/light.svg",
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Container(
                      child: Column(
                        children: [
                          (data_value[0][i] == 1) || (data_value[0][i] == "1")
                              ? AutoSizeText(
                            data[i]
                                .toString()
                                .split("Button")[0]
                                .replaceAll("_", " ") +
                                "",
                            style: GoogleFonts.robotoSlab(
                              /*fontSize: 12,*/ color: Colors.white),
                            maxLines: 1,
                            minFontSize: 7,
                          )
                              : AutoSizeText(
                            data[i]
                                .toString()
                                .split("Button")[0]
                                .replaceAll("_", " ") +
                                "",
                            style: GoogleFonts.robotoSlab(
                              /*fontSize: 12,*/ color: Colors.white),
                            maxLines: 1,
                            minFontSize: 7,
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
      ));
    }
    else if (data[i].toString().contains("Push") &&
        data[i].toString().contains(widget.room_name)) {
      buttonsList.add(Container(
          child: InkWell(
              onTap: () {
                check().then((intenet) {
                  if (intenet) {
                    // Internet Present Case
                    if ((data_value[0][i] == 1) || (data_value[0][i] == "1")) {
                      setState(() {
                        data_value[0][i] = 0;
                        up = "False";
                      });
                    } else {
                      setState(() {
                        data_value[0][i] = 1;
                        up = "True";
                      });
                    }
                    setState(() {
                      // if(widget.check_url==false){
                      //   update_value(data[i],data_value[0][i], i);
                      // }else{
                      //   update_value(data[i],up, i);
                      // }

                      update_value(data[i],up, i);
                      _buildButtonsWithNames();
                    });
                    //print("Connection: present");
                  } else {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          backgroundColor: Colors.black,
                          title: Text(
                            "No Internet Connection",
                            style: TextStyle(color: Colors.white),
                          ),
                          content: Text(
                              "Please check your Internet Connection",
                              style: TextStyle(color: Colors.white)),
                        ));
                    //print("Connection: not present");
                  }
                });
              },
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.12,
                // width: MediaQuery.of(context).size.width * 0.265,
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width * 0.37,

                  padding: const EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: (data_value[0][i] == 0) || (data_value[0][i] == "0")? Colors.grey[900]:Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            color: Colors.grey[700],
                            blurRadius: 1,
                            spreadRadius: 1),
                        BoxShadow(
                            offset: Offset(1, 1),
                            color: Colors.black87,
                            blurRadius: 1,
                            spreadRadius: 1)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.2,
                        margin: EdgeInsets.only(top: 10),
                        child:
                        SvgPicture.asset(
                          "images/ac.svg",
                          height: MediaQuery.of(context).size.height * 0.051,
                        ),

                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Container(
                        child: Column(
                          children: [
                            (data_value[0][i] == 1) || (data_value[0][i] == "1")
                                ? AutoSizeText(
                              data[i]
                                  .toString()
                                  .split("Fan")[0]
                                  .replaceAll("_", " ") +
                                  "",
                              style: GoogleFonts.robotoSlab(
                                color: Colors.white, /*fontSize: 12*/
                              ),
                              maxLines: 1,
                              minFontSize: 10,
                            )
                                : AutoSizeText(
                              data[i]
                                  .toString()
                                  .split("Fan")[0]
                                  .replaceAll("_", " ") +
                                  "",
                              style: GoogleFonts.robotoSlab(
                                /*fontSize: 12,*/ color: Colors.white),
                              maxLines: 1,
                              minFontSize: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )))));
    }
    else if (data[i].toString().contains("Slide") &&
        data[i].toString().contains(widget.room_name)) {
      buttonsList.add(Container(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.12,
            // height: MediaQuery.of(context).size.height * 0.17,
            // width: MediaQuery.of(context).size.width * 0.33,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: Colors.grey[700],
                      blurRadius: 1,
                      spreadRadius: 1),
                  BoxShadow(
                      offset: Offset(1, 1),
                      color: Colors.black87,
                      blurRadius: 1,
                      spreadRadius: 1)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /*Text(data[i].toString().split("Slide")[0].replaceAll("_", " "),
                      style: GoogleFonts.robotoSlab(color: Colors.black)),*/
                    Text(
                        "Fan Speed  ${data_value[0][i].toString().substring(0, 1)}",
                        style: GoogleFonts.robotoSlab(color: Colors.white)),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Slider(
                    activeColor: Colors.yellowAccent,
                    inactiveColor: Colors.grey[500],
                    value: double.parse(data_value[0][i]),
                    min: 0,
                    max: 4,
                    divisions: 4,
                    label: data_value[0][i].toString().substring(0, 1),
                    onChangeEnd: (double value) {
                      check().then((intenet) {
                        if (intenet) {
                          // Internet Present Case

                          setState(() {
                            data_value[0][i] = value.toInt().toString();
                            /*update_value(data[i], data_value[0][i], i);
                          _buildButtonsWithNames();*/
                          });
                          //print("Connection: present");
                        } else {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                backgroundColor: Colors.black,
                                title: Text(
                                  "No Internet Connection",
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Text(
                                    "Please check your Internet Connection",
                                    style: TextStyle(color: Colors.white)),
                              ));
                        }
                        setState(() {
                          update_value(data[i], data_value[0][i], i);
                          _buildButtonsWithNames();
                        });
                      });
                    },
                    onChanged: (double value) {
                      setState(() {
                        data_value[0][i] = value.toString();
                      });
                    },
                  ),
                )
              ],
            )),
      ));
    }
    else if (data[i].toString().contains("Switch") &&
        data[i].toString().contains(widget.room_name)) {
      buttonsList.add(Container(
          child: InkWell(
              onTap: () {
                check().then((intenet) {
                  if (intenet) {
                    // Internet Present Case
                    if ((data_value[0][i] == 1) || (data_value[0][i] == "1")) {
                      setState(() {
                        data_value[0][i] = 0;
                        up = "False";
                      });
                    } else {
                      setState(() {
                        data_value[0][i] = 1;
                        up = "True";
                      });
                    }
                    setState(() {
                      // if(widget.check_url==false){
                      //   update_value(data[i],data_value[0][i], i);
                      // }else{
                      //   update_value(data[i],up, i);
                      // }

                      update_value(data[i],up, i);
                      _buildButtonsWithNames();
                    });
                    //print("Connection: present");
                  } else {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          backgroundColor: Colors.black,
                          title: Text(
                            "No Internet Connection",
                            style: TextStyle(color: Colors.white),
                          ),
                          content: Text(
                              "Please check your Internet Connection",
                              style: TextStyle(color: Colors.white)),
                        ));
                    //print("Connection: not present");
                  }
                });
              },
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.12,
                // width: MediaQuery.of(context).size.width * 0.265,
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width * 0.37,

                  padding: const EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: (data_value[0][i] == 0) || (data_value[0][i] == "0")? Colors.grey[900]:Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            color: Colors.grey[700],
                            blurRadius: 1,
                            spreadRadius: 1),
                        BoxShadow(
                            offset: Offset(1, 1),
                            color: Colors.black87,
                            blurRadius: 1,
                            spreadRadius: 1)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.2,
                        margin: EdgeInsets.only(top: 10),
                        child:
                        SvgPicture.asset(
                          "images/ac.svg",
                          height: MediaQuery.of(context).size.height * 0.051,
                        ),

                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Container(
                        child: Column(
                          children: [
                            (data_value[0][i] == 1) || (data_value[0][i] == "1")
                                ? AutoSizeText(
                              data[i]
                                  .toString()
                                  .split("Switch")[0]
                                  .replaceAll("_", " ") +
                                  "",
                              style: GoogleFonts.robotoSlab(
                                color: Colors.white, /*fontSize: 12*/
                              ),
                              maxLines: 1,
                              minFontSize: 10,
                            )
                                : AutoSizeText(
                              data[i]
                                  .toString()
                                  .split("Switch")[0]
                                  .replaceAll("_", " ") +
                                  "",
                              style: GoogleFonts.robotoSlab(
                                /*fontSize: 12,*/ color: Colors.white),
                              maxLines: 1,
                              minFontSize: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )))));
    }
  }
  SharedPreferences loginData;
  String ip;


  void initial() async {
    local_ip = widget.local_ip;
    loginData = await SharedPreferences.getInstance();
    setState(() {
      loginData.setString('ip', local_ip);
      ip = loginData.getString('ip');
    });
  }


  Future<http.Response> update_value(button, button_value, i) async {

    final response =
    await http.get(Uri.http("$ip", "/$button/$button_value"));
    if (response.statusCode == 200) {
      result = true;
      // print("response 1 : ${response.body}");
      if (response.body != "success");
      // _showScaffold("Update Failed, Please check server or internet connection and retry");
    } else {
      if ((data_value[0][i] == 0) || (data_value[0][i] == "0")) {
        setState(() {
          data_value[0][i] = 1;
          _buildButtonsWithNames();
        });
      } else {
        setState(() {
          data_value[0][i] = 0;
          _buildButtonsWithNames();
        });
      }
      result = false;
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return response;
  }

  Future<http.Response> call() async {

    final response = await http.get(Uri.http("$ip", "/key"));
    if (response.statusCode == 200) {
      // print("response: ${response.statusCode}");
      setState(() {
        data = jsonDecode(response.body);
      });

      // print("values $data");
      // print("response: ${response.body}");
      result = true;
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //  return Album.fromJson(json.decode(response.body));
    } else {
      setState(() {
        result = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return response;
  }

  Future<bool> call_value() async {


    final response = await http.get(Uri.http("$ip", "/value"));

    if (response.statusCode == 200) {
      // print("response: ${response.statusCode}");
      setState(() {
        data_value = jsonDecode(response.body);
      });
      // print("response 2: ${response.body}");
      result2 = true;

      Future.delayed(const Duration(seconds: 5), () {
// Here you can write your code

        setState(() {
          // print("after");

          for (int i = 0; i < data_value[0].length; i++) {
            // print(data_value[0][i]);
            data_value[0][i] = data_value[0][i];
          }

          // _buildButtonsWithNames();

          // Here you can write your code for open new view
        });
      });
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //  return Album.fromJson(json.decode(response.body));
    } else {
      setState(() {
        result2 = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return true;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List data;
  List data_value;
  List<Container> buttonsList = List<Container>();
  String title;
  bool result = false;
  bool result2 = false;
  Offset _offset = Offset.zero;
  Color c;
  double _currentSliderValue = 0;
  bool isSwitched;
  Timer timer;
  List name = [];
  List pg = [];
  String button_name;
  String local_ip;

  Future get_name() async {
    //final response = await http.get('http://34.83.46.202.xip.io/cyberhome/home.php?username=${widget.email}&query=table');
    //final response = await http.get('http://$local_ip/key/');
    final response = await http.get(Uri.http("$ip", "/key"));

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
      // print(name);
    });
    return "success";
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    initial();
    get_name();
    // print("mood check ${widget.isDark}");
    check().then((intenet) {
      if (intenet) {
        call().then((value) => call_value());
      } else {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: Colors.black,
              title: Text(
                "No Internet Connection",
                style: TextStyle(color: Colors.white),
              ),
              content: Text("Please check your Internet Connection",
                  style: TextStyle(color: Colors.white)),
            ));
        //print("Connection: not present");
      }
    });
    timer = Timer.periodic(
        Duration(seconds: 3),
            (Timer t) => check().then((intenet) {
          if (intenet) {
            call().then((value) => call_value());
          } else {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.black,
                  title: Text(
                    "No Internet Connection",
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Text("Please check your Internet Connection",
                      style: TextStyle(color: Colors.white)),
                ));
          }
        }));
    //  call_value();
    super.initState();
    // print("data ${data.toString()}");
    // print("data_value ${data_value.toString()}");

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      check().then((intenet) {
        if (intenet) {
          call().then((value) => call_value());
        } else {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.black,
                title: Text(
                  "No Internet Connection",
                  style: TextStyle(color: Colors.white),
                ),
                content: Text("Please check your Internet Connection",
                    style: TextStyle(color: Colors.white)),
              ));
          //print("Connection: not present");
        }
      }
      );
      timer = Timer.periodic(
          Duration(seconds: 3),
              (Timer t) => check().then((intenet) {
            if (intenet) {
              call().then((value) => call_value());
            } else {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: Colors.black,
                    title: Text(
                      "No Internet Connection",
                      style: TextStyle(color: Colors.white),
                    ),
                    content: Text(
                        "Please check your Internet Connection",
                        style: TextStyle(color: Colors.white)),
                  ));
            }
          })); //   _showScaffold("resume");
      // user returned to our app
    } else if (state == AppLifecycleState.inactive) {
      // print("app:inactive");
      timer?.cancel();
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      timer?.cancel();
      // print("app:pause");
      // user is about quit our app temporally
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // return Stack(
    //   children: [
    //     Container(
    //       child: Container(
    //         margin:EdgeInsets.only(bottom: height*0.06),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             //SizedBox(width: width*0.12,),
    //             IconButton(icon: Icon(Icons.keyboard_backspace_outlined,color: Colors.white,), onPressed: (){Navigator.pop(context);}),
    //             Container(child: Center(child: Text(widget.room_name.toString().replaceAll("_", " "),style: GoogleFonts.robotoSlab(fontSize: 18,color: Colors.white),))),
    //
    //             Container(
    //               padding:  const EdgeInsets.all(15.0),
    //             ),
    //           ],
    //         ),
    //       ),
    //       height: height*0.15,
    //       width: width*1,
    //       decoration: BoxDecoration(
    //         gradient: widget.g1,
    //       ),
    //     ),
    //     Container(
    //         margin: EdgeInsets.only(top:height*0.09),
    //         width: width*12,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.only(topLeft: Radius.elliptical(20, 20),topRight:Radius.elliptical(20,20) ),
    //           //color: widget.c1,
    //           color:Colors.grey[900],
    //         ),
    //         child:SingleChildScrollView(
    //           child: Column(
    //             children: [
    //               result && result2
    //                   ? SingleChildScrollView(child: Container(padding:EdgeInsets.all(5),
    //                   child: Wrap(
    //                   spacing: 20.0,
    //                   children: _buildButtonsWithNames(),
    //               )))
    //                   : Container(
    //                 child: Container(
    //                   margin: EdgeInsets.only(top:height*0.4),
    //                   padding: EdgeInsets.all(10),
    //                   child: CircularProgressIndicator(
    //                     backgroundColor: Colors.grey[700],
    //                     valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         )
    //     )
    //   ],
    // );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: height * 1.0,
        width: width * 1.0,
        child: Stack(children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 1.0),
                          Color.fromRGBO(38, 42, 45, 1.0),
                        ],
                        stops: [
                          0.1,
                          0.9
                        ])),
                child: Container(
                  height: height * 0.54,
                  width: width * 1.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.7),
                              BlendMode.dstATop),
                          image: ((widget.room_name.toString().replaceAll("_", " ") == "Hall"))
                              ? AssetImage(
                            "images/room/hall.png",
                          )
                              : ((widget.room_name.toString().replaceAll("_", " ") == "Admin Room"))
                              ? AssetImage(
                            "images/room/admin room.png",
                          ) : ((widget.room_name.toString().replaceAll("_", " ") == "Garage"))
                              ? AssetImage(
                            "images/room/garage.png",
                          )
                              : ((widget.room_name.toString().replaceAll("_", " ") == "Kitchen"))
                              ? AssetImage(
                            "images/room/kitchen.png",
                          )
                              : ((widget.room_name.toString().replaceAll("_", " ") == "Bathroom 1"))
                              ? AssetImage(
                            "images/room/bathroom 1.png",
                          ): ((widget.room_name.toString().replaceAll("_", " ") == "Bathroom 2"))
                              ? AssetImage(
                            "images/room/bathroom 2.png",
                          )
                              : ((widget.room_name.toString().replaceAll("_", " ") ==  "Bedroom_1"))
                              ? AssetImage(
                            "images/room/bedroom 1.png",
                          )
                              : ((widget.room_name.toString().replaceAll("_", " ") ==  "Bedroom_2"))
                              ? AssetImage(
                            "images/room/bedroom 2.png",
                          )
                              : ((widget.room_name.toString().replaceAll("_", " ") ==  "Master Bedroom"))
                              ? AssetImage(
                            "images/room/master bedroom.png",
                          )
                              : ((widget.room_name.toString().replaceAll("_", " ") ==  "Bedroom"))
                              ? AssetImage(
                            "images/room/bedroom 2.png",
                          )
                              : ((widget.room_name.toString().replaceAll("_", " ") ==  "Kids_Room"))
                              ? AssetImage(
                            "images/room/kids bedroom.png",
                          )
                              : ((widget.room_name.toString().replaceAll("_", " ") ==  "Outside"))
                              ? AssetImage(
                            "images/room/outside.png",
                          )
                              : ((widget.room_name.toString().replaceAll("_", " ") ==  "Garden"))
                              ? AssetImage(
                            "images/room/garden.png",
                          )
                              : ((widget.room_name.toString().replaceAll("_", " ") ==  "Parking"))
                              ? AssetImage(
                            "images/room/parking.png",
                          )
                              : ((widget.room_name.toString().replaceAll("_", " ") ==  "Living_Room"))
                              ? AssetImage(
                            "images/room/living room.png",

                          )
                              : ((widget.room_name.toString().replaceAll("_", " ") ==  "Store_Room"))
                              ? AssetImage(
                            "images/room/store room.png",
                          )
                              : AssetImage(""),
                          fit: BoxFit.fill)
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                height: height * 0.428,
                width: width * 1.0,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 1.0),
                          Color.fromRGBO(45, 47, 49, 1.0),
                        ],
                        stops: [
                          0.1,
                          0.7
                        ])),

              ),
            ],
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 350.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        widget.room_name.toString().replaceAll("_", " "),
                        style: GoogleFonts.robotoSlab(
                            fontSize: 24, color: Colors.white),
                      )),

                  SizedBox(
                    height: height * 0.010,
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    height: height * 1.0,
                    width: width * 1.0,
                    color: Colors.transparent,
                    // decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //         begin: Alignment.bottomLeft,
                    //         end: Alignment.topRight,
                    //         colors: [
                    //           Color.fromRGBO(0, 0, 0, 1.0),
                    //           Color.fromRGBO(45, 47, 49, 1.0),
                    //         ],
                    //         stops: [
                    //           0.1,
                    //           0.7
                    //         ])),
                    child: Column(
                      children: [
                        result && result2
                            ? Container(
                            padding: EdgeInsets.all(10.0),
                            // color: Colors.red,
                            child: Wrap(
                              spacing: 2.0,
                              children: _buildButtonsWithNames(),
                            ))
                            : Container(
                          child: Container(
                            margin: EdgeInsets.only(top: height * 0.4),
                            padding: EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey[700],
                              valueColor:
                              new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ]
        ),
      ),
    );
  }
}
