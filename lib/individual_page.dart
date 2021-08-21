import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IndividualPage extends StatefulWidget {
  IndividualPage({this.imgValue,this.txtValue});
  final String imgValue;
  final String txtValue;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height*1.0,
        width: width*1.0,
        child: Stack(
          children:[
            Column(
              children: [
                Container(
                  height: height*0.55,
                  width: width*1.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.7), BlendMode.dstATop),
                      image: AssetImage(widget.imgValue),fit: BoxFit.fill
                    )
                  ),
                ),
                Container(
                  height: height*0.45,
                  width: width*1.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 1.0),
                        Color.fromRGBO(45, 47, 49, 1.0),
                      ],
                      stops: [0.1,0.7]
                    )
                  ),
                ),
              ],
            ),
            // Positioned(
            //  top: height*0.35,
            //   child: Container(
            //     child: Column(
            //       children: [
            //         Text(
            //           "Living Room",style: GoogleFonts.inter(
            //           color: Colors.white,
            //           fontWeight: FontWeight.bold,
            //         ),
            //         ),
            //         GridView.count(
            //             crossAxisCount: 3,
            //             crossAxisSpacing: 4.0,
            //             mainAxisSpacing: 8.0,
            //             children: List.generate(choices.length, (index) {
            //               return Center(
            //                 child: SelectCard(choice: choices[index]),
            //               );
            //             }
            //             )
            //         )
            //       ],
            //     ),
            //   ),
            // )

          ]
        ),
      ),
    );
  }
}



class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Home', icon: Icons.home),
  const Choice(title: 'Contact', icon: Icons.contacts),
  const Choice(title: 'Map', icon: Icons.map),
  const Choice(title: 'Phone', icon: Icons.phone),
  const Choice(title: 'Camera', icon: Icons.camera_alt),
  const Choice(title: 'Setting', icon: Icons.settings),
  const Choice(title: 'Album', icon: Icons.photo_album),
  const Choice(title: 'WiFi', icon: Icons.wifi),
];

class SelectCard extends StatefulWidget {
  const SelectCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  _SelectCardState createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
bool sts = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white38,
            offset: Offset(
              -2.5,
              -2.5,
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
      child: Container(
        height: height * 0.20,
        width: width * 0.80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("images/light.svg",height: height*0.030,),
                  SizedBox(
                    height: height * 0.041
                  ),
                  Text(
                    "Light",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 13.0),
                  ),
                ],
              ),
              Switch(
                  activeColor: Colors.orange,
                  thumbColor: MaterialStateProperty.all(Colors.orange),
                  value: sts,
                  onChanged: (bool value) {
                    setState(() {
                      sts = value;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}