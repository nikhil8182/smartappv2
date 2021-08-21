import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SecondDashBoard extends StatefulWidget {
  const SecondDashBoard({Key key}) : super(key: key);

  @override
  _SecondDashBoardState createState() => _SecondDashBoardState();
}

class _SecondDashBoardState extends State<SecondDashBoard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(26, 28, 30, 0.6),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                // height: 40.0,
                height: height*0.045,

              ),
              Text(
                "Dashboard",
                style: GoogleFonts.inter(
                    fontSize: height*0.033,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                // height: 30.0,
                height: height*0.033,
              ),
              Center(
                child: Text(
                  "Power Source",
                  style: GoogleFonts.inter(fontSize: height*0.018, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    // height: 80.0,
                    // width: 180.0,
                    height: height*0.080,
                    width: width*0.42,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(64, 60, 60, 1.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          child: SvgPicture.asset(
                            "images/battery-svgrepo-com.svg",
                            // height: 20.0,
                            height: height*0.022,
                            color: Colors.red.shade100,
                          ),
                          backgroundColor: Colors.orange,
                          radius: height*0.022,
                        ),
                        Text(
                          "Inverter",
                          style: GoogleFonts.inter(
                              fontSize: height*0.018,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // height: 80.0,
                    // width: 180.0,
                    height: height*0.080,
                    width: width*0.42,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(64, 60, 60, 1.0),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          child: SvgPicture.asset(
                            "images/eb.svg",
                            // height: 20.0,
                            height: height*0.022,
                            color: Colors.red.shade100,
                          ),
                          backgroundColor: Colors.orange,
                          radius: height*0.022,
                        ),
                        Text(
                          "Electricity",
                          style: GoogleFonts.inter(
                              fontSize: height*0.017,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                // height: 20.0,
                height: height*0.022,
              ),
              Center(
                child: Container(
                  // height: 80.0,
                  // width: 370.0,
                  height: height*0.080,
                  width: width*0.86,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color.fromRGBO(64, 60, 60, 1.0),
                          Color.fromRGBO(40, 26, 26, 1.0),
                        ],
                        stops: [
                          0.1,
                          0.9
                        ]),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Remaining Battery",
                        style: GoogleFonts.inter(
                            fontSize: height*0.017,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      CircularPercentIndicator(
                        backgroundColor: Color.fromRGBO(56, 56, 56, 1.0),
                        radius: height*0.054,
                        lineWidth: 5.0,
                        animation: true,
                        percent: 0.4,
                        center: new Text(
                          "40 %",
                          style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 9.0,color: Colors.grey),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor:  Color.fromRGBO(255, 82, 82, 1.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height*0.022,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  "Water level",
                  style: GoogleFonts.inter(
                    fontSize: height*0.017,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: height*0.022,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    // height: 290.0,
                    // width: 120.0,
                    height: height*0.32,
                    width: width*0.29,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color.fromRGBO(0, 22, 31, 1.0),
                              Color.fromRGBO(0, 0, 0, 1.0),
                            ],
                            stops: [
                              0.1,
                              0.9
                            ]),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: LiquidLinearProgressIndicator(
                      value: 0.5, // Defaults to 0.5.
                      valueColor: AlwaysStoppedAnimation( Color.fromRGBO(
                          91, 156, 170, 1.0),), // Defaults to the current Theme's accentColor.
                      backgroundColor: Colors.transparent, // Defaults to the current Theme's backgroundColor.
                      borderColor: Colors.black,
                      borderWidth: 2.0,
                      borderRadius: 20.0,
                      direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                      center: Text("50 %",style: GoogleFonts.inter(color: Colors.grey,fontSize: 20.0),),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Container(
                          // height: 200.0,
                          // width: 240.0,
                          height: height*0.23,
                          width: width*0.55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(66, 55, 143, 1.0),
                                  Color.fromRGBO(245, 56, 68, 1.0),
                                ],
                                stops: [
                                  0.1,
                                  0.9
                                ]),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "EB BILL",
                                      style: GoogleFonts.inter(
                                        fontSize: height*0.022,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Today's Bill",
                                      style: GoogleFonts.inter(
                                        fontSize: height*0.015,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      " ₹  122.0",
                                      style: GoogleFonts.inter(
                                        fontSize: height*0.028,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Total Bill",
                                      style: GoogleFonts.inter(
                                        fontSize: height*0.013,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      " ₹ 1140.0",
                                      style: GoogleFonts.inter(
                                        fontSize: height*0.025,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height*0.012,
                      ),
                      Center(
                        child: Container(
                          // height: 75.0,
                          // width: 240.0,
                          height: height*0.075,
                          width: width*0.55,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(70, 70, 70, 1.0),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Power",
                                    style: GoogleFonts.inter(
                                      fontSize: height*0.014,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Consumption",
                                    style: GoogleFonts.inter(
                                      fontSize: height*0.014,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Unit",
                                    style: GoogleFonts.inter(
                                      fontSize:height*0.014,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "215",
                                    style: GoogleFonts.inter(
                                      fontSize: height*0.019,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: height*0.022,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Security System",
                        style: GoogleFonts.inter(
                            fontSize: height*0.013, color: Colors.white),
                      ),
                      SizedBox(
                        height: height*0.011,
                      ),
                      Container(
                        // height: 70.0,
                        // width: 170.0,
                        height: height*0.078,
                        width: width*0.40,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 179, 0, 1.0),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Center(
                            child: Image(
                          image: AssetImage("images/lock.png"),
                          height: height*0.033,
                        )),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Total Running Devices",
                        style: GoogleFonts.inter(
                            fontSize:height*0.013, color: Colors.white),
                      ),
                      SizedBox(
                        height:height*0.011,
                      ),
                      Container(
                        // height: 70.0,
                        // width: 170.0,
                        height: height*0.078,
                        width: width*0.40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromRGBO(255, 174, 0, 1.0),
                                Color.fromRGBO(255, 216, 133, 1.0),
                              ],
                              stops: [
                                0.1,
                                0.9
                              ]),
                        ),
                        child: Center(
                          child: Text(
                            "24",
                            style: GoogleFonts.inter(
                                fontSize: height*0.029,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
