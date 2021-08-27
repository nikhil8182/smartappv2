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

class _IndividualPageState extends State<IndividualPage> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                    height: height * 0.45,
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
                        mainAxisSpacing: 12.0,
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
  const Choice({this.title, this.image});
  final String title;
  final String image;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Light', image: "images/light.svg"),
  const Choice(title: 'Ac', image: "images/ac.svg"),
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Switch(
                        activeColor: Colors.white,
                        thumbColor: MaterialStateProperty.all(Colors.white),
                        value: value,
                        onChanged: (bool newValue) {
                          setState(() {
                            value = newValue;
                          });
                        }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        widget.choice.image,
                        height: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        widget.choice.title,
                        style: GoogleFonts.inter(fontSize: 20.0),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
