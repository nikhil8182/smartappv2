import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onwords_home/bottomTabs/Settings_page.dart';
import 'package:onwords_home/bottomTabs/firstPage.dart';
import 'package:onwords_home/dashbord/second_dashBoard.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'bottomTabs/routine_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool valueStatus = false;
  int _currentIndex = 0;

  List page = [
    FirstPage(),
    SecondDashBoard(),
    RoutinePage(),
    DummySettingsPage(),
  ];


  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor:  Color.fromRGBO(40, 36, 36, 1.0),
      // backgroundColor: Color.fromRGBO(26, 28, 30, 0.6),
      backgroundColor: Color.fromRGBO(26, 28, 30, 1.0),
      body: page[_currentIndex],
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.symmetric(horizontal: 1.0),
      //   width: double.infinity,
      //   decoration: BoxDecoration(
      //     color: Colors.black,
      //     borderRadius: BorderRadius.circular(20.0),
      //   ),
      //   child: BottomNavigationBar(
      //     items: const <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //         backgroundColor: Colors.transparent,
      //         icon: Icon(Icons.home),
      //         label: 'Home',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.business),
      //         label: 'Business',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.dashboard),
      //         label: 'DashBoard',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.settingsPage),
      //         label: 'Settings',
      //       ),
      //     ],
      //     backgroundColor: Colors.white,
      //     selectedItemColor: Colors.amber[800],
      //     unselectedItemColor: Colors.grey,
      //     currentIndex: _currentIndex,
      //     onTap: (int index) {
      //       setState(() {
      //         _currentIndex = index;
      //       });
      //     }
      //   ),
      // ),
        bottomNavigationBar: FloatingNavbar(
        borderRadius: 20.0,
          selectedBackgroundColor: Colors.orange,
          unselectedItemColor: Colors.white,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: [
            FloatingNavbarItem(customWidget: SvgPicture.asset("images/home.svg"),title: 'Home'),
            FloatingNavbarItem(customWidget: SvgPicture.asset("images/dash.svg"), title: 'Dashboard'),
            FloatingNavbarItem(customWidget: SvgPicture.asset("images/routine.svg"), title: 'Routine'),
            FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
          ],
        ),
    );
  }
}
