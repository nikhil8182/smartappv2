import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onwords_home/settingsPage/tab_sett/Tab_Page.dart';

class TabSettingsPage extends StatefulWidget {
  @override
  _TabSettingsPageState createState() => _TabSettingsPageState();
}

class _TabSettingsPageState extends State<TabSettingsPage> {
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
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 70.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Tab Settings",
                style: GoogleFonts.inter(
                  fontSize: height * 0.032,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.030,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Select Tab",
                style: GoogleFonts.inter(
                  fontSize: height * 0.020,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.035,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              color: Colors.transparent,
              child: Column(
                children: [
                  TabCard(txt: " Living Room ",),
                  SizedBox(
                    height: height*0.020,
                  ),
                  TabCard(txt: " Bed Room ",),
                  SizedBox(
                    height: height*0.020,
                  ),
                  TabCard(txt: " Kitchen Room ",),
                  SizedBox(
                    height: height*0.020,
                  ),
                  TabCard(txt: " Bed Room 2 ",),
                  SizedBox(
                    height: height*0.020,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class TabCard extends StatefulWidget {
  TabCard({this.txt});

final String txt;

  @override
  _TabCardState createState() => _TabCardState();
}

class _TabCardState extends State<TabCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>TabPage()));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 5.0),
          title: Text(widget.txt,style: GoogleFonts.inter(
            color: Colors.white
          ),),
        ),
      ),
    );
  }
}
