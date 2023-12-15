import 'package:flutter/material.dart';
import 'package:readhub/together/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/together/widgets/navbar.dart';
import 'package:readhub/Home/widgets/profile_widget.dart';
import 'package:readhub/Home/widgets/profileupper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topPadding = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    double availableHeight = screenHeight - topPadding - bottomPadding ;
     double appBarHeight = AppBar().preferredSize.height;

     return Scaffold(
      
      backgroundColor: Warna.blue,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Profile',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              height: 1.5,
              color: Warna.white,
            ),
          ),
        ),
        backgroundColor: Warna.blue,
        foregroundColor: Warna.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(index: 4),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter, // Mengatur konten di bagian bawah
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: availableHeight / 2 - appBarHeight*1.7 - appBarHeight*0.3,
                      child: Container(
                        color: Warna.blue, // Set the background color here
                        child: ProfileUpper(),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: availableHeight/2 - appBarHeight*0.5,
                      child: Container(
                        color: Warna.blue, // Set the background color here
                        child: ProfileSection(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

