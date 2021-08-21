import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onwords_home/Routine_Page/routine_page_final.dart';

class RoutinePage1 extends StatefulWidget {


  @override
  _RoutinePage1State createState() => _RoutinePage1State();
}

class _RoutinePage1State extends State<RoutinePage1> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromRGBO(26, 28, 30, 0.6),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // height: 40.0,
              height: height*0.075,
            ),
            Text(
              " Routines ",
              style: GoogleFonts.inter(
                  fontSize: height*0.038,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              // height: 20.0,
              height: height*0.035,
            ),
            Center(
              child: Text(
                " Create new routines ",
                style: GoogleFonts.inter(
                    fontSize: height*0.015,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            SizedBox(
              // height: 20.0,
              height: height*0.035,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 58.0),
              child: Container(
                height: height*0.095,
                width: width*0.75,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(54, 54, 54, 1.0),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Center(
                  child: IconButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RoutinePageFinal()));
                  }, icon: Icon(Icons.add,color: Colors.black,size:height*0.04,),),
                ),
              ),
            )
          ],
        )
    );
  }
}
