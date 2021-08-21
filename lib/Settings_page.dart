import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DummySettingsPage extends StatefulWidget {


  @override
  _DummySettingsPageState createState() => _DummySettingsPageState();
}

class _DummySettingsPageState extends State<DummySettingsPage> {
  bool buttonStatus = false;
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(26, 28, 30, 0.6),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // height: 40.0,
            height: height*0.075,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              " Settings ",
              style: GoogleFonts.inter(
                  fontSize: height*0.028,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            // height: 20.0,
            height: height*0.025,
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
                backgroundColor: Color.fromRGBO(94, 94, 94, 1.0),
                child: Image(
                  image: AssetImage("images/account.png"),height: height*0.028,
                ),
              ),
              title: Text(
              "ArunKumar ",
              style: GoogleFonts.inter(
                  fontSize: height*0.022,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
              subtitle:Text(
                "Account Settings ",
                style: GoogleFonts.inter(
                    fontSize: height*0.013,
                    color: Colors.white),
              ),
              trailing: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(94, 94, 94, 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image(
                  image: AssetImage("images/arrow.png"),height: height*0.028,
                ),
              ),
            ),
          ),
          SizedBox(
            // height: 20.0,
            height: height*0.025,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(54, 54, 54, 1.0),
                borderRadius: BorderRadius.circular(30.0)
              ),
              child: Column(
                children: [
                 SettingsListTile(imgValue: "images/sun.png",titleTxt: "Theme ",subTitleTxt: "Light ",),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                      height: height*0.004,
                    ),
                  ),
                  SettingsListTile(imgValue: "images/sun.png",titleTxt: "Notification ",subTitleTxt: "ON ",),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                      height: height*0.004,
                    ),
                  ),
                  SettingsListTile(imgValue: "images/sun.png",titleTxt: "Connectivity ",subTitleTxt: "Online ",),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                      height: height*0.004,
                    ),
                  ),
                  SettingsListTile(imgValue: "images/sun.png",titleTxt: "Sound ",subTitleTxt: "ON ",),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                      height: height*0.004,
                    ),
                  ),
                  SettingsListTile(imgValue: "images/sun.png",titleTxt: "Tab Settings ",subTitleTxt: "ON ",),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                      height: height*0.004,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}


class SettingsListTile extends StatefulWidget {
SettingsListTile({this.imgValue,this.titleTxt,this.subTitleTxt});
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
          backgroundColor: Color.fromRGBO(94, 94, 94, 1.0),
          child: Image(
            image: AssetImage(widget.imgValue),height: height*0.028,
          ),
        ),
        title: Text(
          widget.titleTxt,
          style: GoogleFonts.inter(
              fontSize: height*0.022,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        subtitle:Text(
          widget.subTitleTxt,
          style: GoogleFonts.inter(
              fontSize: height*0.013,
              color: Colors.white),
        ),
        trailing: Switch(
            inactiveTrackColor: Colors.grey,
            activeColor: Colors.orange,
            thumbColor:
            MaterialStateProperty.all(Colors.orange),
            value: buttonStatus,
            onChanged: (bool value) {
              setState(() {
                buttonStatus = value;
              });
            })
    );
  }
}
