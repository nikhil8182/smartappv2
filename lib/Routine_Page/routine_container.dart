import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoutineContainer extends StatefulWidget {
  RoutineContainer({this.title,this.onLongPressCallBack});
  final String title;
  final Function onLongPressCallBack;

  @override
  _RoutineContainerState createState() => _RoutineContainerState();
}

class _RoutineContainerState extends State<RoutineContainer> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onLongPress: widget.onLongPressCallBack,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: height*0.15,
        width: width*0.30,
        decoration: BoxDecoration(
            color: Color.fromRGBO(54, 54, 54, 1.0),
            borderRadius: BorderRadius.circular(20.0)
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){},
                  icon: Icon(Icons.power_settings_new,size:height * 0.031,),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.inter(
                      fontSize: height*0.014,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  " 6 Devices ",
                  style: GoogleFonts.inter(
                      fontSize: height*0.010,
                      color: Colors.white),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
