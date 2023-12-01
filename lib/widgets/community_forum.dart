import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/models/forum.dart';
import 'package:readhub/styles/colors.dart';

class CommunityForumWidget extends StatelessWidget {
  final Forum forum;
  CommunityForumWidget({Key? key, required this.forum}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final contentWidth = screenHeight - 28 * 2;

    return Container(
      width: contentWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0 , 0 , 0 , 24),
            width: contentWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0 , 0 , 0, 8 ),
                  width: screenHeight ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0 , 0 , 148, 12),
                        width: contentWidth,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0 , 0, 12, 0 ),
                              width: 56 ,
                              height: 56 ,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(26),
                                child: Image.asset(
                                  'assets/images/Profile.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              forum.name,
                              style: GoogleFonts.poppins(
                                fontSize: 16 ,
                                fontWeight: FontWeight.w700,
                                height: 1.6,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: contentWidth,
                        ),
                        child: Text(
                          forum.forumText,
                          style: GoogleFonts.poppins(
                            fontSize: 15 ,
                            fontWeight: FontWeight.w500,
                            height: 1.5 ,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6),
                Container(
                  width: contentWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0 , 0, 0 , 8 ),
                        child: Text(
                          'Book',
                          style: GoogleFonts.poppins(
                            fontSize: 16 ,
                            fontWeight: FontWeight.w600,
                            height: 1.5 ,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10 , 10 , 10),
                        width: contentWidth,
                        // height: 190 ,
                        decoration: BoxDecoration(
                          color: Color(0xff23264f),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: 247 ,
                          // height: contentWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0 , 10 , 0 ),
                                // height: contentWidth,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(6.0704197884),
                                ),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: SizedBox(
                                    width: 84,
                                    height: 128,
                                    child: Image.network(
                                      forum.bookImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 8 , 0 , 8 ),
                                width: 240 ,
                                // height:contentWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0 , 0 , 0, 8 ),
                                      width: contentWidth-40,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0 , 0 , 0, 6 ),
                                            child: Text(
                                              forum.bookTitle,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14 ,
                                                fontWeight: FontWeight.w600,
                                                height: 1.5,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'by: ${forum.bookAuthor}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12 ,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5 ,
                                              color: Color(0xff818181),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Tambahkan aksi untuk tombol ini
                                      },
                                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(17.5, 8, 17.5, 8 ),
                                        width: 120,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Warna.blue,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'See detail',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              height: 1.5,
                                              color: Colors.white,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: screenHeight,
            height: 1.5, 
            color: Warna.backgroundlight, 
          ),
          SizedBox(height: 28),
        ],
      ),
    );
  }
}
