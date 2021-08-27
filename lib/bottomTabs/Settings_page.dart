import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onwords_home/log_ins/login_page.dart';
import 'package:onwords_home/settingsPage/tab_sett/tab_settings_page.dart';

class DummySettingsPage extends StatefulWidget {
  @override
  _DummySettingsPageState createState() => _DummySettingsPageState();
}

class _DummySettingsPageState extends State<DummySettingsPage> {
  bool buttonStatus = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
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
      child: Scaffold(
        backgroundColor: Color.fromRGBO(26, 28, 30, 0.6),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // height: 40.0,
                height: height * 0.075,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  " Settings ",
                  style: GoogleFonts.inter(
                      fontSize: height * 0.028,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                // height: 20.0,
                height: height * 0.025,
              ),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  tileColor: Color.fromRGBO(54, 54, 54, 1.0),
                  leading: CircleAvatar(
                    radius: height * 0.030,
                    backgroundColor: Color.fromRGBO(94, 94, 94, 1.0),
                    child: Image(
                      image: AssetImage("images/account.png"),
                      height: height * 0.028,
                    ),
                  ),
                  title: Text(
                    "ArunKumar ",
                    style: GoogleFonts.inter(
                        fontSize: height * 0.022,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    "Account Settings ",
                    style: GoogleFonts.inter(
                        fontSize: height * 0.013, color: Colors.white),
                  ),
                  trailing: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(94, 94, 94, 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image(
                      image: AssetImage("images/arrow.png"),
                      height: height * 0.028,
                    ),
                  ),
                ),
              ),
              SizedBox(
                // height: 20.0,
                height: height * 0.025,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(54, 54, 54, 1.0),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Column(
                    children: [
                      SettingsListTile(
                        imgValue: "images/sun.png",
                        titleTxt: "Theme ",
                        subTitleTxt: "Light ",
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 48.0),
                        child: Divider(
                          thickness: 1.0,
                          color: Colors.grey,
                          height: height * 0.004,
                        ),
                      ),
                      SettingsListTile(
                        imgValue: "images/sun.png",
                        titleTxt: "Notification ",
                        subTitleTxt: "ON ",
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 48.0),
                        child: Divider(
                          thickness: 1.0,
                          color: Colors.grey,
                          height: height * 0.004,
                        ),
                      ),
                      SettingsListTile(
                        imgValue: "images/sun.png",
                        titleTxt: "Connectivity ",
                        subTitleTxt: "Online ",
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 48.0),
                        child: Divider(
                          thickness: 1.0,
                          color: Colors.grey,
                          height: height * 0.004,
                        ),
                      ),
                      SettingsListTile(
                        imgValue: "images/sun.png",
                        titleTxt: "Sound ",
                        subTitleTxt: "ON ",
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 48.0),
                        child: Divider(
                          thickness: 1.0,
                          color: Colors.grey,
                          height: height * 0.004,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TabSettingsPage()));
                          },
                          child: SettingsListTile(
                            imgValue: "images/sun.png",
                            titleTxt: "Tab Settings ",
                            subTitleTxt: "ON ",
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                // height: 20.0,
                height: height * 0.025,
              ),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(54, 54, 54, 1.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal:18.0 ),
                    height: height * 0.080,
                    width: width * 0.96,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: height * 0.030,
                          backgroundColor: Color.fromRGBO(94, 94, 94, 1.0),
                          child: Image(
                            image: AssetImage("images/logout.png"),
                            height: height * 0.028,
                          ),
                        ),
                        SizedBox(
                          width: width*0.045,
                        ),
                        Text(
                          "Logout ",
                          style: GoogleFonts.inter(
                              fontSize: height * 0.022,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsListTile extends StatefulWidget {
  SettingsListTile({this.imgValue, this.titleTxt, this.subTitleTxt});
  final String imgValue;
  final String titleTxt;
  final String subTitleTxt;

  @override
  _SettingsListTileState createState() => _SettingsListTileState();
}

class _SettingsListTileState extends State<SettingsListTile> {
  bool buttonStatus = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.black),
        ),
        tileColor: Color.fromRGBO(54, 54, 54, 1.0),
        leading: CircleAvatar(
          radius: height * 0.030,
          backgroundColor: Color.fromRGBO(94, 94, 94, 1.0),
          child: Image(
            image: AssetImage(widget.imgValue),
            height: height * 0.028,
          ),
        ),
        title: Text(
          widget.titleTxt,
          style: GoogleFonts.inter(
              fontSize: height * 0.022,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        subtitle: Text(
          widget.subTitleTxt,
          style:
              GoogleFonts.inter(fontSize: height * 0.013, color: Colors.white),
        ),
        trailing: Switch(
            inactiveTrackColor: Colors.grey,
            activeColor: Colors.orange,
            thumbColor: MaterialStateProperty.all(Colors.orange),
            value: buttonStatus,
            onChanged: (bool value) {
              setState(() {
                buttonStatus = value;
              });
            }));
  }
}
