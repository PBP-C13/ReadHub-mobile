import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readhub/Home/screens/home.dart';
import 'package:readhub/together/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/auth/screens/login.dart';



class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    const double fem = 1.0;
    return Scaffold(
      backgroundColor: Warna.blue,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Onboarding Screen.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView( // Scrollable container
              child: Container(
                padding: EdgeInsets.fromLTRB(28   , 36   , 28   , 45   ),
                decoration: const BoxDecoration(
                  color: Color(0xff161832),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40   ),
                    topRight: Radius.circular(40   ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0   , 0   , 0   , 24   ),
                      constraints: const BoxConstraints(
                        maxWidth: 293   ,
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 30   ,
                            fontWeight: FontWeight.w800,
                            height: 1.2    / fem,
                            color: Color(0xffffffff),
                          ),
                          children: [
                            const TextSpan(
                              text: 'Start Your Journey In ',
                            ),
                            TextSpan(
                              text: 'ReadHub!',
                              style: GoogleFonts.poppins(
                                color: Color(0xff3fbcfc),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0   , 0   , 0   , 22   ),
                      constraints: const BoxConstraints(
                        maxWidth: 280   ,
                      ),
                      child: Text(
                        'Ayo explore dan pinjam buku dengan mudah dan cepat',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16   ,
                          fontWeight: FontWeight.w500,
                          height: 1.2875    / fem,
                          letterSpacing: 0.4   ,
                          color: Color(0xffb6b6b6),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0   , 0   , 0   , 12   ),
                      child: TextButton(
                        
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginApp()), // Navigate to LoginApp
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(98   , 20   , 98   , 20   ),
                          width: double.infinity,
                          height: 64   ,
                          decoration: BoxDecoration(
                            color: Color(0xff2a4cf1),
                            borderRadius: BorderRadius.circular(24   ),
                          ),
                          child: Center(
                            child: Text(
                              'Login ReadHub',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 1.5    / fem,
                                color: Warna.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Homescreen()), 
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(86, 20, 86, 20),
                        width: double.infinity,
                        height: 64   ,
                        decoration: BoxDecoration(
                          color: Color(0x332a4cf1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Text(
                            'Guest Account',
                            style: GoogleFonts.poppins(
                              fontSize: 16   ,
                              fontWeight: FontWeight.w700,
                              height: 1.5    / fem,
                              color: Warna.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
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
