import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  double range = 20.0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
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
            0.5
          ])),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 70.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Tab Settings",
                style: GoogleFonts.inter(
                  fontSize: height * 0.036,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.050,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              color: Colors.transparent,
              child: Column(
                children: [
                  TabCardSettings(
                    txt: " Screen Light ",
                  ),
                  SizedBox(
                    height: height * 0.020,
                  ),
                  TabCardSettings(
                    txt: " Sound ",
                  ),
                  SizedBox(
                    height: height * 0.020,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.030,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                height: height*0.15,
                width: width*0.90,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tab Volume",
                          style: GoogleFonts.inter(
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          range.round().toString(),
                          style: GoogleFonts.inter(
                            fontSize: height * 0.018,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                Slider(
                  value: range,
                  min: 0,
                  max: 100,
                  activeColor: Colors.orangeAccent,
                  inactiveColor: Colors.grey,
                  label:range.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      range = value;
                    });
                  },
                ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class TabCardSettings extends StatefulWidget {
  TabCardSettings({this.txt});

  final String txt;

  @override
  _TabCardSettingsState createState() => _TabCardSettingsState();
}

class _TabCardSettingsState extends State<TabCardSettings> {
  bool buttonStatus = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        leading: CircleAvatar(
          radius: height * 0.023,
          backgroundColor: Colors.grey.withOpacity(0.5),
          child: Image(
            image: AssetImage('images/sun.png'),
            height: height * 0.030,
          ),
        ),
        title: Text(
          widget.txt,
          style: GoogleFonts.inter(color: Colors.white),
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
            }),
      ),
    );
  }
}
