import 'package:flutter/material.dart';
import 'package:readhub/models/forum.dart';
import 'package:readhub/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/widgets/navbar.dart';
import 'package:readhub/screens/navigation/home.dart';
import 'package:readhub/screens/navigation/explore.dart';
import 'package:readhub/screens/navigation/mybook.dart';
import 'package:readhub/screens/navigation/profile.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Warna.background,
      bottomNavigationBar: BottomNavBar(index: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 21),
                      width: double.infinity,
                      height: 56,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 100, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: screenWidth - (screenWidth / 2.25),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                                  child: Text(
                                    'Welcome,',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5,
                                      color: Color(0xffb6b6b6),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Arya Wijaya! 👋🏻',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    height: 1.4,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 56,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xff3fbcfc),
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 278.55,
                                height: 278.55,
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Image.network(
                                    'assets/images/Profile.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 26, 16, 26),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff2a4cf1),
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('assets/images/Explore card.png'),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                            constraints: BoxConstraints(
                              maxWidth: 162,
                            ),
                            child: Text(
                              'Explore Buku Favoritmu!',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                height: 1.3333333333,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ExploreScreen()));
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              width: 112,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xff3fbcfc),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'Explore',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3333333333,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 52,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      padding: EdgeInsets.fromLTRB(18.32, 15, 120, 13),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff292c4f),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 15.05, 0.38),
                            width: 15.64,
                            height: 15.72,
                            child: Image.network(
                              '[Image url]',
                              width: 15.64,
                              height: 15.72,
                            ),
                          ),
                          Container(
                            width: 200,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: 52,
                        height: 52,
                        child: Image.network(
                          '[Image url]',
                          width: 52,
                          height: 52,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
