import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onwords_home/Routine_Page/grid_containers.dart';
import 'package:onwords_home/Routine_Page/routine_page1.dart';
//import 'package:onwords_home/Routine_Page/routine_page_final.dart';

class RoutinePage extends StatefulWidget {
  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          backgroundColor: Colors.black.withOpacity(0.9),
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 90.0,
          backgroundColor: Colors.transparent,
          title: Text(
            " Routines ",
            style: GoogleFonts.inter(
                fontSize: height * 0.030,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showAnotherAlertDialog(context);
                      // Navigator.pushNamed(context, '/first');
                      // Navigator.popAndPushNamed(context, '/first');
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SchedulePage()), (route) => true);
                    },
                    icon: Icon(
                      Icons.add,
                      size: height*0.041,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        //   body: Padding(
        //     padding: EdgeInsets.symmetric(vertical: 38.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         SizedBox(
        //           // height: 40.0,
        //           height: height*0.075,
        //         ),
        //         Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 22.0),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text(
        //                 " Routines ",
        //                 style: GoogleFonts.inter(
        //                     fontSize: height*0.038,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.white),
        //               ),
        //               IconButton(onPressed: (){
        //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>RoutinePage1()));
        //               }, icon: Icon(Icons.add,color: Colors.white,size: 35.0,),),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           // height: 40.0,
        //           height: height*0.075,
        //         ),
        //       // GridView.count(
        //       //     crossAxisCount: 2,
        //       //     crossAxisSpacing: 4.0,
        //       //     mainAxisSpacing: 8.0,
        //       //     children: List.generate(choices.length, (index) {
        //       //       return Center(
        //       //         child: SelectCard(choice: choices[index]),
        //       //       );
        //       //     }
        //       //     )
        //       // )
        //       //   Container(
        //       //     padding: EdgeInsets.symmetric(horizontal: 10.0),
        //       //     height: height*0.15,
        //       //     width: width*0.30,
        //       //     decoration: BoxDecoration(
        //       //       color: Color.fromRGBO(54, 54, 54, 1.0),
        //       //       borderRadius: BorderRadius.circular(20.0)
        //       //     ),
        //       //
        //       //     child: Column(
        //       //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       //       crossAxisAlignment: CrossAxisAlignment.start,
        //       //       children: [
        //       //         Row(
        //       //          mainAxisAlignment:MainAxisAlignment.end,
        //       //           children: [
        //       //             IconButton(onPressed: (){},
        //       //                 icon: Icon(Icons.power_settings_new,size: 30.0,),
        //       //             ),
        //       //           ],
        //       //         ),
        //       //         Column(
        //       //           crossAxisAlignment: CrossAxisAlignment.start,
        //       //           children: [
        //       //             Text(
        //       //               " Good Morning ",
        //       //               style: GoogleFonts.inter(
        //       //                   fontSize: height*0.014,
        //       //                   fontWeight: FontWeight.bold,
        //       //                   color: Colors.white),
        //       //             ),
        //       //             Text(
        //       //               " 6 Devices ",
        //       //               style: GoogleFonts.inter(
        //       //                   fontSize: height*0.010,
        //       //                   color: Colors.white),
        //       //             ),
        //       //           ],
        //       //         )
        //       //
        //       //       ],
        //       //     ),
        //       //   )
        //         Container(
        //           color: Colors.white,
        //             child: TaskView()),
        //       ],
        // ),
        //   )
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          color: Color.fromRGBO(26, 28, 30, 0.6),
          child: TaskView(),
        ),
      ),
    );
  }
  showAnotherAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("ok"),
      onPressed: (){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RoutinePage1()));
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text("Routines ",style: TextStyle(color: Colors.white60,fontWeight: FontWeight.bold),),
      content: Text(" Features are Coming Soon ",style: TextStyle(color: Colors.white60),),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert ;
      },
    );
  }
}
