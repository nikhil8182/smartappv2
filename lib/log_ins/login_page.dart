import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onwords_home/log_ins/installation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_page.dart';
import '../main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  String loginState;
  SharedPreferences loginData;
  bool newUser;

  bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;


  @override
  void initState() {
    check_if_already_login();
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
    email = TextEditingController();
    pass = TextEditingController();
    super.initState();
  }


  void check_if_already_login() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool('login') ?? true);
    // print(newUser);
    if (newUser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height * 1.0,
          width: width * 1.0,
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 38.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/logo.png'),
                  height: height * 0.15,
                ),
                SizedBox(
                  height: height * 0.050,
                ),
                Center(
                  child: Container(
                    width: width * 0.81,
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 90.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
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
                          ]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white38,
                          offset: Offset(
                            0.0,
                            3.0,
                          ),
                          blurRadius: 0.0,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(0, 2, 0, 1.0),
                          offset: Offset(
                            2.0,
                            2.0,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 38.0),
                          child: Container(
                            // height: 60.0,
                            height: height * 0.067,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white38,
                                  offset: Offset(
                                    -4.0,
                                    -1.0,
                                  ),
                                  blurRadius: 0.0,
                                  spreadRadius: 1.0,
                                ),
                                BoxShadow(
                                  color: Color.fromRGBO(0, 2, 0, 1.0),
                                  offset: Offset(
                                    -4.0,
                                    -1.0,
                                  ),
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: email,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: "Username",
                                  hintStyle: TextStyle(color: Colors.white30),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: width * 0.001),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.040,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 38.0),
                          child: Container(
                            // height: 60.0,
                            height: height * 0.067,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white38,
                                  offset: Offset(
                                    -4.0,
                                    -1.0,
                                  ),
                                  blurRadius: 0.0,
                                  spreadRadius: 1.0,
                                ),
                                BoxShadow(
                                  color: Color.fromRGBO(0, 2, 0, 1.0),
                                  offset: Offset(
                                    -4.0,
                                    -1.0,
                                  ),
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: pass,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.black26,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.white30),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: width * 0.001),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.040,
                        ),
                        OutlinedButton(
                            onPressed: () async {
                              //print("$hasInternet inetrnet is available or not_____________________------------------");

                              hasInternet = await InternetConnectionChecker().hasConnection;
                              result = await Connectivity().checkConnectivity();

                              //print("$hasInternet inetrnet is after pressing the button  ++++++++++++++");

                              if(hasInternet) {
                                try {
                                  await auth.signInWithEmailAndPassword(email: email.text,password: pass.text);
                                  setState(() {
                                    loginData.setBool('login', false);
                                    loginData.setString('username', email.text);

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InstallationPage()));
                                    // loginState = "logedin succesfully";
                                    // print(
                                    //     "curent user = ${Firebase.auth.UserProfile}");
                                  });
                                } catch (e) {
                                  setState(() {
                                    loginState = "Acess denied";
                                  });
                                }
                              }
                              else{
                                showSimpleNotification(
                                  Text("No Network",
                                    style: TextStyle(color: Colors.white),),
                                  background: Colors.red,
                                );
                              }

                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(12.0)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(247, 167, 28, 1.0)),
                            ),
                            child: Text(
                              " Sign In ",
                              style: GoogleFonts.inter(
                                  color: Colors.white, fontSize: 16.0),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.030,
                ),
                GestureDetector(
                  onTap: () async {
                    //print("$hasInternet inetrnet is available or not_____________________------------------");

                    hasInternet = await InternetConnectionChecker().hasConnection;
                    result = await Connectivity().checkConnectivity();

                    //print("$hasInternet inetrnet is after pressing the button  ++++++++++++++");

                    if(hasInternet) {
                      try {
                        await auth.signInWithEmailAndPassword(email: "demo@onwords.in",password: "123456");
                        setState(() {
                          loginData.setBool('login', false);
                          loginData.setString('username', email.text);

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage()));
                          // loginState = "logedin succesfully";
                          // print(
                          //     "curent user = ${Firebase.auth.UserProfile}");
                        });
                      } catch (e) {
                        setState(() {
                          loginState = "Acess denied";
                        });
                      }
                    }
                    else{
                      showSimpleNotification(
                        Text("No Network",
                          style: TextStyle(color: Colors.white),),
                        background: Colors.red,
                      );
                    }

                  },
                  child: Container(
                    height: height * 0.070,
                    width: width * 0.81,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
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
                          ]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white38,
                          offset: Offset(
                            -3.0,
                            -1.0,
                          ),
                          blurRadius: 0.0,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(0, 2, 0, 1.0),
                          offset: Offset(
                            1.0,
                            3.0,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/login.svg',
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Text(
                            "Demo Login",
                            style: GoogleFonts.inter(
                                fontSize: height * 0.016,
                                color: Colors.white60,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
