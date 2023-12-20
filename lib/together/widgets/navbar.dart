import 'package:flutter/material.dart';
import 'package:readhub/Community/screens/community.dart';
import 'package:readhub/Explore/screens/explore.dart';
import 'package:readhub/Home/models/user.dart';
import 'package:readhub/Home/screens/home.dart';
import 'package:readhub/Borrow/screens/mybook.dart';
import 'package:readhub/Home/screens/profile.dart';
import 'package:readhub/together/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/together/widgets/notlogin.dart';

// Global variable for screens
List<Widget> widgetOptions = <Widget>[
  const Homescreen(),
  const ExploreScreen(),
  const CommunityScreen(),
  const MyBookScreen(),
  const ProfileScreen(),
];

class BottomNavBar extends StatefulWidget {
  final int index;
  // ignore: prefer_const_constructors_in_immutables
  BottomNavBar({Key? key, required this.index}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
    if ((index == 2 || index == 3 || index == 4) && !isUserLoggedIn) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const notLogin(),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.of(context).push(_createRoute(widgetOptions.elementAt(index)));
    }
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
      transitionDuration: const Duration(milliseconds: 600),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Warna.backgrounddark,
      height: screenHeight / 8,
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Book'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Warna.white,
        unselectedItemColor: Warna.backgroundsuperlight,
        backgroundColor: Colors.transparent,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
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
