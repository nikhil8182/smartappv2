import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


class GeoLocationPage extends StatefulWidget {
  @override
  _GeoLocationPageState createState() => _GeoLocationPageState();
}
var lat , lon;
var url =  'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=98e8dfcf4ea2319b693eb4c58b2a6018&units=metric';

class _GeoLocationPageState extends State<GeoLocationPage> {
  Position _currentPosition; //class to get the lat&log
  //String _currentAddress;
  SharedPreferences loginData;
  int weather = 0;
  int temp = 0;
  Timer timer;

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      weather = loginData.getInt('weather');
       print("$weather  =============");
    });

  }

  @override
  void initState() {

    _getCurrentLocation();
    initial();
    // timer = Timer.periodic(
    //     Duration(seconds: 1),
    //     (Timer t)=> initial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
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
                Color.fromRGBO(247, 179, 28, 1.0),
                Color.fromRGBO(255, 210, 112, 1.0),
              ],
              stops: [0.1, 0.7],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text(
                        //   "${weather.toString()}",
                        //   // temp.toString(),
                        //   style: GoogleFonts.montserrat(
                        //     fontSize: height * 0.045,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        ((weather.toString())=="null")?CircularProgressIndicator(
                          backgroundColor: Colors.grey[700],
                          valueColor:
                          new AlwaysStoppedAnimation<Color>(
                              Colors.white),
                        )
                            :Text(
                            "${weather.toString()}",
                            // temp.toString(),
                            style: GoogleFonts.montserrat(
                              fontSize: height * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        Text(
                          "°C",
                          style: GoogleFonts.montserrat(
                            fontSize: height * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
    );
  }

  _getCurrentLocation() {
   //print("im inside the get location");
    // _getAddressFromLatLng();
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState((){
        _currentPosition = position;
        _getAddressFromLatLng();


      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    //print("im inside the getAdderess location");
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          _currentPosition.latitude,
          _currentPosition.longitude
      );

      Placemark place = placeMarks[0];
      //print("i am running curretly%&%^%*&^&%^&%^(%*&^%&^%(&^%*(^&%*^(%*^");


     setState(() async {
        lat = _currentPosition.latitude;
        lon = _currentPosition.longitude;

        //print("$_currentPosition  ======================");
        //print("url = $url");
        var j = await http.get(Uri.parse(url));
        print("wether json = ${j.body}");
         var json = jsonDecode(j.body) ;

              double temp1 = json["main"]["temp"];
              temp = temp1.round();
        //print("${temp.round()} of the weather");
        loginData = await SharedPreferences.getInstance();
        loginData.setInt('weather', temp);


        print("${temp.round()} of the weather");
        //weather = loginData.getInt('weather');
        //print("$weather ---------");
        // print("city = ${json["name"]}");
        // print("weather = ${json["main"]["temp"]}");
      });
    }
    catch (e) {
      print(e);
    }
  }
}
