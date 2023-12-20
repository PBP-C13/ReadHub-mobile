import 'package:flutter/material.dart';
import 'package:readhub/Home/models/user.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileUpper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.fromLTRB(28.0, 28, 28.0, 0.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(13.5   , 0   , 13   , 0   ),
              width: 140,
              height: 140   ,
              decoration: BoxDecoration(
                color: Color(0xff3fbcfc),
                borderRadius: BorderRadius.circular(99999999999999 ),
              ),
              child: Align(
                // LR3 (485:1135)
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 498,
                  height: 498 ,
                  child: Image.asset(
                    'assets/images/Profile Cyan.png', // Ganti dengan URL gambar yang sesuai
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20  ,
            ),
            Text(
              userlogin,
              style: GoogleFonts.poppins(
                fontSize: 24   ,
                fontWeight: FontWeight.w700,
                height: 1.4 ,
                color: Color(0xffffffff),
              ),
            ),
            SizedBox(
              height: 10   ,
            ),
            Text(
              // registeruser7q7 (485:1137)
              'Register User',
              style: GoogleFonts.poppins(
                fontSize: 18 ,
                fontWeight: FontWeight.w500,
                height: 1.5 ,
                letterSpacing: 0.4800001144   ,
                color: Color(0xffc8c8c8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}