// ignore_for_file: unused_element

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readhub/models/borrowed_book.dart';
import 'package:readhub/screens/navigation/mybook.dart';
import 'package:readhub/styles/colors.dart';

class MyBookCard extends StatelessWidget {
   final BorrowedBook borrowedBook;
  MyBookCard({Key? key, required this.borrowedBook}) : super(key: key);

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

  Future<void> _returnBook(BuildContext context, CookieRequest request, BorrowedBook borrowedBook) async {
    await request.postJson(
      'https://readhub-c13-tk.pbp.cs.ui.ac.id/borrow_flow/return_book_flutter/${borrowedBook.book.id}/',
      jsonEncode({
        "id": borrowedBook.book.id,
      }),
    );
    Navigator.of(context).push(_createRoute(const MyBookScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final request = context.watch<CookieRequest>();

    return Container(
      padding: EdgeInsets.fromLTRB(16, 20, 13, 20),
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        color: Color(0xff23264f),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                height: 125.6,
                                decoration: BoxDecoration(
                                  color: Warna.background,
                                  borderRadius: BorderRadius.circular(6.0704197884),
                                ),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 84.48,
                                    height: 125.46,
                                    decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: DecorationImage(
                                      image: NetworkImage(borrowedBook.book.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 11, 0, 11),
                                width: screenWidth / 2,
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                                            child: Text(
                                              borrowedBook.book.bookTitle,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14 ,
                                                fontWeight: FontWeight.w600,
                                                height: 1.4285714286 ,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'by: ${borrowedBook.book.bookAuthors}',
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
                                  Container(
                                    width: screenWidth / 2,
                                    height: 24,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: borrowedBook.book.genres.split('|').length,
                                      itemBuilder: (BuildContext context, int index) {
                                        if (index < 3) {
                                          String genre = borrowedBook.book.genres.split('|')[index].trim();
                                          return Container(
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                              color: Color(0xff3fbcfc),
                                              borderRadius: BorderRadius.circular(999),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0), // Adjust the padding as needed
                                              child: Center(
                                                child: Text(
                                                  genre,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.6,
                                                    color: Color(0xffffffff),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container(); // Return an empty container for indexes beyond 2 (to show a maximum of 3 genres)
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth,
                  height: 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 40), // Adjust the spacing between the left and right items
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 0),
                              child: Text(
                                'Tanggal\nPeminjaman ',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3333333333,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                            Text(
                              borrowedBook.borrowDate.toString().substring(0, 11),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(), // This will expand to fill the available space between the left and right items
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 0),
                              child: Text(
                                'Tanggal\nPengembalian ',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3333333333,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                            Text(
                              borrowedBook.returnDate.toString().substring(0, 11),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    'Pengembalian Buku',
                    style: GoogleFonts.poppins(
                      fontSize: 14 ,
                      fontWeight: FontWeight.w600,
                      height: 1.3333333333 ,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: Text(
                    'Buku ini harus dikembalikan dengan keadaan Sama seperti semula',
                    style: GoogleFonts.poppins(
                      fontSize: 14 ,
                      fontWeight: FontWeight.w600,
                      height: 1.4285714286 ,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 20, 3, 0),
              child: Material(
                color: Colors.transparent,
                child: InkResponse(
                  onTap: () {
                    // Handle button press action
                    _returnBook(context, request, borrowedBook);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: screenWidth,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Warna.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 9.4, 0),
                            width: 13.5,
                            height: 13.5,
                            child: Image.network(
                              'assets/icons/check-square-fill.png',
                              width: 13.5,
                              height: 13.5,
                            ),
                          ),
                          Text(
                            'Kembalikan Buku',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              height: 1.3333333333,
                              color: Warna.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),     
    );
  }
}
