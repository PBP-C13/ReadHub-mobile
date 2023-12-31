import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readhub/together/models/book.dart';
import 'package:readhub/Borrow/screens/mybook.dart';
import 'package:readhub/together/style/colors.dart';

class BorrowScreen extends StatefulWidget {
  final Book book;

  BorrowScreen({required this.book});

  @override
  State<BorrowScreen> createState() => _BorrowScreenState();
}

class _BorrowScreenState extends State<BorrowScreen> {
  late Book _book;
  void initState(){
    super.initState();
    _book = widget.book;
  }

  int _days = 1; // Initial number of days

  void _increaseDays() {
    setState(() {
      // Increase the number of days, but limit it to a maximum of 7
      _days = (_days < 7) ? _days + 1 : _days;
    });
  }

  void _decreaseDays() {
    setState(() {
      // Decrease the number of days, but limit it to a minimum of 1
      _days = (_days > 1) ? _days - 1 : _days;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      
      backgroundColor: Warna.background,
      appBar: AppBar(
        title: Text(
          'Borrow Book',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.5,
            color: Warna.white,
          ),
        ),
        backgroundColor: Warna.background,
        foregroundColor: Warna.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(8.5, 100, 8.5, 52),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(81.5, 0, 81.5, 0),
                        width: 155.65,
                        height: 218,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 155.65,
                            height: 218,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: NetworkImage(_book.fields.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 28),
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                              constraints: BoxConstraints(
                                maxWidth: 315,
                              ),
                              child: Text(
                                _book.fields.bookTitle,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  height: 1.4,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                            Text(
                              'by ${
                                (_book.fields.bookAuthors.length) > 18
                                    ? (_book.fields.bookAuthors.substring(0, 18).replaceAll("|", ", ")) + '...'
                                    : _book.fields.bookAuthors.replaceAll("|", ", ")
                              }',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.4285714286,
                                color: Color(0xffb6b6b6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 28),
                      Container(
                        margin: EdgeInsets.fromLTRB(48.5, 0, 48.5, 0),
                        width: double.infinity,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center the Row horizontally
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _decreaseDays();
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                child: Container(
                                  width: 56,
                                  height: 56,
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      size: 24,
                                      color: Warna.cyan,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Warna.lightcyan,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                '$_days hari', // I WANT TO UPDATE THIS EVERYTIME THE BUTTON IS CLICKED
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  height: 1.4,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              SizedBox(width: 20),
                              TextButton(
                                onPressed: () {
                                  _increaseDays();
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                child: Container(
                                  width: 56,
                                  height: 56,
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 24,
                                      color: Warna.cyan,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Warna.lightcyan,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final response = await request.postJson(
                      "https://readhub-c13-tk.pbp.cs.ui.ac.id/borrow_flow/borrow_book_flutter/",
                      jsonEncode(<String, dynamic>{
                        'borrow_duration': _days.toString(),
                        'book_title': _book.fields.bookTitle,
                        'return_date' : DateTime.now().add(Duration(days: _days)).toString(),
                      }));
                    if(response['status'] == 'success'){
                      ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Berhasil meminjam buku ${_book.fields.bookTitle}!"),
                        ));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyBookScreen(),
                          ),
                        );   
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(100, 16, 100, 16),
                    width: 360,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Color(0xff2a4cf1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the Row horizontally
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 13, 0),
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            "assets/icons/Bag.png", // Replace with the actual image URL
                            width: 18,
                            height: 20,
                          ),
                        ),
                        Container(
                          width: 120,
                          height: double.infinity,
                          child: Center(
                            child: Text(
                              'Pinjam Buku',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
