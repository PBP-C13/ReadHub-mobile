import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readhub/screens/auth/register.dart';
import 'package:readhub/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/screens/auth/login.dart';



class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    const double fem = 1.0;
    const double ffem = 1.0;
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
                padding: EdgeInsets.fromLTRB(28 * fem, 36 * fem, 28 * fem, 45 * fem),
                decoration: const BoxDecoration(
                  color: Color(0xff161832),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40 * fem),
                    topRight: Radius.circular(40 * fem),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 24 * fem),
                      constraints: const BoxConstraints(
                        maxWidth: 293 * fem,
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 30 * ffem,
                            fontWeight: FontWeight.w800,
                            height: 1.2 * ffem / fem,
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
                      margin: const EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 22 * fem),
                      constraints: const BoxConstraints(
                        maxWidth: 280 * fem,
                      ),
                      child: Text(
                        'Ayo explore dan pinjam buku dengan mudah dan cepat',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.2875 * ffem / fem,
                          letterSpacing: 0.4 * fem,
                          color: Color(0xffb6b6b6),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),
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
                          padding: const EdgeInsets.fromLTRB(98 * fem, 20 * fem, 98 * fem, 20 * fem),
                          width: double.infinity,
                          height: 64 * fem,
                          decoration: BoxDecoration(
                            color: Color(0xff2a4cf1),
                            borderRadius: BorderRadius.circular(24 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Login ReadHub',
                              style: GoogleFonts.poppins(
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.5 * ffem / fem,
                                color: Color(0xffffffff),
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
                          MaterialPageRoute(builder: (context) => RegisterApp()), 
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(86, 20, 86, 20),
                        width: double.infinity,
                        height: 64 * fem,
                        decoration: BoxDecoration(
                          color: Color(0x332a4cf1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Text(
                            'Register ReadHub',
                            style: GoogleFonts.poppins(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.5 * ffem / fem,
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
