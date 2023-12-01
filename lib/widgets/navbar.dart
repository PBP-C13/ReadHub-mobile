import 'package:flutter/material.dart';
import 'package:readhub/screens/menu.dart';
import 'package:readhub/screens/navigation/community.dart';
import 'package:readhub/screens/navigation/explore.dart';
import 'package:readhub/screens/navigation/home.dart';
import 'package:readhub/screens/navigation/mybook.dart';
import 'package:readhub/screens/navigation/profile.dart';
import 'package:readhub/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';



// Variabel global untuk screen
List<Widget> widgetOptions = <Widget>[
  Homescreen(),
  ExploreScreen(),
  CommunityScreen(),
  MyBookScreen(),
  MyHomePage(),
];

class BottomNavBar extends StatefulWidget {
  final int index;
  BottomNavBar({Key? key, required this.index}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
  Navigator.of(context).push(_createRoute(widgetOptions.elementAt(index)));
}

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: 600), // Durasi transisi
  );
}


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Warna.backgrounddark, // Warna background Container
      height: screenHeight / 8, // Tinggi Container
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Book'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Menu'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Warna.white,
        unselectedItemColor: Warna.backgroundsuperlight,
        backgroundColor: Colors.transparent, // Warna background BottomNavigationBar
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Menambahkan ini untuk menghindari shifting

        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
      ),
    );
  }
}
