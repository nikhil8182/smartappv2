import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';
import 'package:location/location.dart';




FirebaseAuth auth = FirebaseAuth.instance;
final databaseReference = FirebaseDatabase.instance.reference();

class GeoLocationPage extends StatefulWidget {
  @override
  _GeoLocationPageState createState() => _GeoLocationPageState();
}
// var lat , lon;
// var url =  'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=98e8dfcf4ea2319b693eb4c58b2a6018&units=metric';

class _GeoLocationPageState extends State<GeoLocationPage> {

//pkjmsyodpxvcgixcdm@sdvgeft.com  --email.id
  SharedPreferences loginData;
  //String key = '5109959ac0573a36a75860a31c6ec5fa';
  String key;
  WeatherFactory ws;
  double lat, lon;
  String des = " ";
  double temp ;
  LocationData _currentPosition;
  String ic = " ";

  Location location = Location();

  double sharedTemp = 0.0 ;
  String sharedDes = " ";
  double sharedLat = 0.0;
  double sharedLon = 0.0 ;
  var dataJson;
  String onlineWeatherLink;
  String localWeatherLink;



  Future<void> fireData() async {
    databaseReference.child(auth.currentUser.uid).once().then((DataSnapshot snapshot) async {

      // setState(() {
      //   dataJson = snapshot.value;
      //   // data1 = dataJson.keys.toList();
      //   //print(dataJson);
      //   userName = dataJson["name"];
      //   ipLocal = dataJson["ip"].toString();
      // });

      dataJson = snapshot.value;
      // data1 = dataJson.keys.toList();
      //print(dataJson);

      onlineWeatherLink = dataJson["weather"];
      loginData = await SharedPreferences.getInstance();
      loginData.setString('weatherLink', onlineWeatherLink );
      localWeatherLink = loginData.getString("weatherLink");
      //print("$localWeatherLink the key is localWeatherLink");
      initial();
    });
  }

  Future<void> initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      key = loginData.getString("weatherLink");
      //print("$key is key");
      ws = WeatherFactory(key);
      getLoc();
      sharedTemp = loginData.getDouble('temp');
      sharedDes = loginData.getString('des');
      sharedLon = loginData.getDouble('lon');
      sharedLat = loginData.getDouble('lat');

      // print("$sharedTemp =============");
      // print(" ---------------- $sharedDes =============");
    });
  }

  @override
  void initState() {
    fireData();
    //getLoc();
    // ws = WeatherFactory(key);
    Timer.periodic(Duration(minutes: 10), (Timer t) => getLoc());
    initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                    Text(sharedDes?? "  "),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text(
                        //   "33",
                        //   // temp.toString(),
                        //   style: GoogleFonts.montserrat(
                        //     fontSize: height * 0.045,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        ((sharedTemp.toString())=="null")?CircularProgressIndicator(
                          backgroundColor: Colors.grey[700],
                          valueColor:
                          new AlwaysStoppedAnimation<Color>(
                              Colors.white),
                        )
                            :Text(
                            "${sharedTemp.toString()}",
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
  void queryWeather() async {
    //print("hello query weather");
    FocusScope.of(context).requestFocus(FocusNode());

    loginData = await SharedPreferences.getInstance();
    loginData.setDouble('lat', lat);
    loginData.setDouble('lon', lon);
    //print("$lat na $lon");
    Weather weather = await ws.currentWeatherByLocation(sharedLat, sharedLon);
    //print("${weather.tempMax} , ${weather.temperature},  ${weather.weatherDescription},  ${weather.cloudiness}");
    setState(() {
      //_data = [weather];
      temp = weather.temperature.celsius.roundToDouble();

      //print("${weather.tempMax.runtimeType} temp is================");
      des = weather.weatherDescription;
      ic = weather.weatherIcon;
      //print("${ weather.weatherIcon} icon 000000000s");
      // print("$des des is================");
    });

    loginData = await SharedPreferences.getInstance();
    loginData.setDouble('temp', temp);
    loginData.setString('des', des);

  }

  getLoc() async{
    //print("22222222222im inside the get loc hello999999999999999999");

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      //print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        lat = (_currentPosition.latitude);
        lon = (_currentPosition.longitude);
        //print("$lat and $lon  im inside the getloc");
        fireData();
        queryWeather();
      });
    });
  }

}
