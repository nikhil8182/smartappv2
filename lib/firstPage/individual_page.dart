import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IndividualPage extends StatefulWidget {
  IndividualPage({this.imgValue, this.txtValue});
  final String imgValue;
  final String txtValue;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

var data;

bool data1 = false;
bool tubeLight = false;
bool tubeLight2 = false;
var rating;
double fan = 0.0;
var roundRat;
bool  wallFan1 = false;
bool  wallFan2 = false;
bool  tFan1 = false;
bool bBulb = false;

class _IndividualPageState extends State<IndividualPage> {
  List val = [];
  Timer timer;


  Future<dynamic> getData() async {
    http.Response response =
        await http.get(Uri.parse('http://192.168.1.18:8000/'));
    Map data = json.decode(response.body);

    setState(() {
      int fan1 = data['Fan_Slide_Admin_Room'];
      fan = fan1.roundToDouble();
      data1 = data['Nfc1'];
      tubeLight = data['Tube_Light_1_Button_Admin_Room'];
      tubeLight2 = data['Tube_Light_2_Button_Admin_Room'];
      wallFan1 = data['Wall_Mount_Fan_1_Push_Admin_Room'];
      wallFan2 = data['Wall_Mount_Fan_2_Push_Admin_Room'];
      tFan1 = data['Tower_Fan_Push_Admin_Room'];
      bBulb = data['Bulb_Button_Admin_Room'];
    });

  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1),(timer)=>getData());
    super.initState();
  }


  bool value = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    getData();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                    height: height * 0.55,
                    width: width * 1.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.7),
                                BlendMode.dstATop),
                            image: AssetImage(widget.imgValue),
                            fit: BoxFit.fill)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  height: height * 0.45,
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
                  // child: GridView.count(
                  //       scrollDirection: Axis.vertical,
                  //         crossAxisCount: 2,
                  //         crossAxisSpacing: 19.0,
                  //         mainAxisSpacing: 12.0,
                  //         children: List.generate(choices.length, (index) {
                  //           return  SelectCard(choice: choices[index]);
                  //         }
                  //         )
                  //     ),
                ),
              ],
              // ),
              // Positioned(
              //  top: height*0.35,
              //   child: Container(
              //     child: Column(
              //       children: [
              //         Text(
              //           "Living Room",style: GoogleFonts.inter(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //         ),
              //         ),
              //         GridView.count(
              //             crossAxisCount: 3,
              //             crossAxisSpacing: 4.0,
              //             mainAxisSpacing: 8.0,
              //             children: List.generate(choices.length, (index) {
              //               return Center(
              //                 child: SelectCard(choice: choices[index]),
              //               );
              //             }
              //             )
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ),
            Positioned(
              top: height * 0.30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      widget.txtValue,
                      style: GoogleFonts.inter(
                        fontSize: height * 0.042,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.001,
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    height: height * 0.60,
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
                    child: GridView.count(
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        crossAxisSpacing: 19.0,
                        mainAxisSpacing: 16.0,
                        children: List.generate(choices.length, (index) {
                          return SelectCard(choice: choices[index]);
                        })),
                  ),

                  // Container(
                  //   child: GridView.count(
                  //     scrollDirection: Axis.vertical,
                  //       crossAxisCount: 2,
                  //       crossAxisSpacing: 2.0,
                  //       mainAxisSpacing: 4.0,
                  //       children: List.generate(choices.length, (index) {
                  //         return  SelectCard(choice: choices[index]);
                  //       }
                  //       )
                  //   ),
                  // ),
                  // Row(
                  //   children: [
                  //     Container(
                  //       height:height*0.15,
                  //       width: width*0.32,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20.0),
                  //         color: Color.fromRGBO(247, 179, 28, 1.0),
                  //       ),
                  //       child: Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                  //         child: Column(
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.end,
                  //               children: [
                  //                 Transform.scale( scale: 1.3,
                  //                   child: Switch(
                  //                     activeColor: Colors.white,
                  //                     thumbColor: MaterialStateProperty.all(Colors.white),
                  //                     value: value,
                  //                     onChanged: (bool newValue) {
                  //                       setState(() {
                  //                         value = newValue;
                  //                       });
                  //                     }),
                  //                 ),
                  //               ],
                  //             ),
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Icon(
                  //                       Icons.wb_incandescent_outlined,size: 40.0,color: Colors.white,
                  //                     ),
                  //                     Text(
                  //                       "Light "
                  //                     )
                  //                   ],
                  //                 ),
                  //               ],
                  //             )
                  //
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       height:height*0.15,
                  //       width: width*0.32,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20.0),
                  //         color: Color.fromRGBO(247, 179, 28, 1.0),
                  //       ),
                  //       child: Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                  //         child: Column(
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.end,
                  //               children: [
                  //                 Transform.scale( scale: 1.3,
                  //                   child: Switch(
                  //                       activeColor: Colors.white,
                  //                       thumbColor: MaterialStateProperty.all(Colors.white),
                  //                       value: value,
                  //                       onChanged: (bool newValue) {
                  //                         setState(() {
                  //                           value = newValue;
                  //                         });
                  //                       }),
                  //                 ),
                  //               ],
                  //             ),
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.start,
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Icon(
                  //                       Icons.wb_incandescent_outlined,size: 40.0,color: Colors.white,
                  //                     ),
                  //                     Text(
                  //                         "Light "
                  //                     )
                  //                   ],
                  //                 ),
                  //               ],
                  //             )
                  //
                  //           ],
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.image, this.url});
  final String title;
  final String image;
  final String url;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Light', image: "images/light.svg", url: "bBulb"),
  const Choice(title: 'Light', image: "images/light.svg", url: "tubeLight"),
  const Choice(title: 'Light', image: "images/light.svg", url: "tubeLight2"),
  const Choice(title: 'Fan', image: "images/ac.svg", url: "wallFan1"),
  const Choice(title: 'Fan', image: "images/ac.svg", url: "wallFan2"),
  // const Choice(title: 'Fan', image: "images/ac.svg", url: "tFan1"),
];

class SelectCard extends StatefulWidget {
  const SelectCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  _SelectCardState createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40.0),
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
      child: GestureDetector(
        onTap: () async {
          print("pressedd+++++");
          setState(() {
            value = !value;
          });

          if ((widget.choice.url) == "bBulb") {
            bBulb
                ? await http.get(Uri.parse(
                'http://192.168.1.18:8000/Bulb_Button_Admin_Room/0/'))
                : await http.get(Uri.parse(
                'http://192.168.1.18:8000/Bulb_Button_Admin_Room/1/'));
            setState(() {
              bBulb = !bBulb;
            });
          }
          if ((widget.choice.url).toString() == "tubeLight") {
            print("im inside ${widget.choice.url}");
            tubeLight
                ? await http.get(Uri.parse(
                    'http://192.168.1.18:8000/Tube_Light_1_Button_Admin_Room/0/'))
                : await http.get(Uri.parse(
                    'http://192.168.1.18:8000/Tube_Light_1_Button_Admin_Room/1/'));
            setState(() {
              tubeLight = !tubeLight;
            });

            // if(tubeLight){
            //   print("im turning off the light");
            //   await http.get(Uri.parse(
            //             'http://192.168.1.18:8000/Tube_Light_1_Button_Admin_Room/1/'));
            //   setState(() {
            //     tubeLight = false;
            //   });
            // }
            // else{
            //   print("im turning ON the light");
            //   await http.get(Uri.parse(
            //       'http://192.168.1.18:8000/Tube_Light_1_Button_Admin_Room/0/'));
            //   setState(() {
            //     tubeLight = true;
            //   });
            // }
          }

          if ((widget.choice.url) == "tubeLight2") {
            tubeLight2
                ? await http.get(Uri.parse(
                    'http://192.168.1.18:8000/Tube_Light_2_Button_Admin_Room/0/'))
                : await http.get(Uri.parse(
                    'http://192.168.1.18:8000/Tube_Light_2_Button_Admin_Room/1/'));
            setState(() {
              tubeLight2 = !tubeLight2;
            });
          }
          if ((widget.choice.url) == "wallFan1") {
            wallFan1
                ? await http.get(Uri.parse(
                'http://192.168.1.18:8000/Wall_Mount_Fan_1_Push_Admin_Room/0/'))
                : await http.get(Uri.parse(
                'http://192.168.1.18:8000/Wall_Mount_Fan_1_Push_Admin_Room/1/'));
            setState(() {
              wallFan1 = !wallFan1;
            });
          }
          if ((widget.choice.url) == "wallFan2") {
            wallFan2
                ? await http.get(Uri.parse(
                'http://192.168.1.18:8000/Wall_Mount_Fan_2_Push_Admin_Room/0/'))
                : await http.get(Uri.parse(
                'http://192.168.1.18:8000/Wall_Mount_Fan_2_Push_Admin_Room/1/'));
            setState(() {
              wallFan2 = !wallFan2;
            });
          }

        },
        child: Container(
          height: height * 0.17,
          width: width * 0.33,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: value
                ? Color.fromRGBO(247, 179, 28, 1.0)
                : Color.fromRGBO(39, 39, 40, 1.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Transform.scale(
                //       scale: 1.3,
                //       child: Switch(
                //           activeColor: Colors.white,
                //           thumbColor: MaterialStateProperty.all(Colors.white),
                //           value: data1,
                //           onChanged: (bool newValue) {
                //             setState(() async {
                //               data1
                //                   ? await http.get(Uri.parse(
                //                       'http://192.168.1.18:8000/Nfc1/0/'))
                //                   : await http.get(Uri.parse(
                //                       'http://192.168.1.18:8000/Nfc1/1/'));
                //             });
                //           }),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          widget.choice.image,
                          height: height * 0.051,
                        ),
                        SizedBox(
                          height: height * 0.010,
                        ),
                        Text(
                          widget.choice.title,
                          style: GoogleFonts.inter(fontSize: height * 0.021),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
