import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/auth/screens/onboarding.dart';
import 'package:readhub/together/style/colors.dart';

// ignore: camel_case_types
class notLogin extends StatefulWidget {
  // ignore: use_super_parameters
  const notLogin({Key? key}) : super(key: key);

  @override
  State<notLogin> createState() => _notLoginState();
}

// ignore: camel_case_types
class _notLoginState extends State<notLogin> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 32, 12, 32),
        width: 320,
        height: 400,
        decoration: BoxDecoration(
          color: Warna.backgrounddark,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center, // Centers horizontally
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(2.5, 0, 0, 19),
              width: 219,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(59.5, 0, 59.5, 16),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xff2e4ee7),
                      borderRadius: BorderRadius.circular(89999),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.asset(
                          'assets/images/notlogin.png', // Replace with your image asset path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Ayo Login',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                      color: const Color(0xffffffff),
                    ),
                  ),
                  const SizedBox(height: 16), // Increased space between "Ayo Login" and description
                  Container(
                    constraints: const BoxConstraints(maxWidth: 219),
                    child: Text(
                      'Untuk mengakses fitur tersebut kamu harus login terlebih dahulu',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 2,
                        color: Warna.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0), // Reduced space between description and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: buttonTemplate('Kembali', Warna.lightblue, Warna.blue),
                ),
                const SizedBox(width: 8), // Space between buttons
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Onboarding()),
                    );
                  },
                  child: buttonTemplate('Login', Warna.blue,Warna.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonTemplate(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(26, 8.5, 26, 8),
      width: 130,
      height: 44,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
