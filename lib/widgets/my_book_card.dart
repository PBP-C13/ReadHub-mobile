import 'package:flutter/material.dart';
import 'package:readhub/models/borrowed_book.dart';

class MyBookCard extends StatelessWidget {
   final BorrowedBook borrowedBook;
  MyBookCard({Key? key, required this.borrowedBook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double fem = 1.0; // Replace with your actual value
    final double ffem = 1.0; // Replace with your actual value

    return Container(
      padding: EdgeInsets.fromLTRB(16 * fem, 20 * fem, 13 * fem, 20 * fem),
      width: double.infinity,
      height: 366 * fem,
      decoration: BoxDecoration(
        color: Color(0xff23264f),
        borderRadius: BorderRadius.circular(20 * fem),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 24 * fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 24 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 24 * fem),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 10 * fem, 0 * fem),
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xff13142a),
                                  borderRadius: BorderRadius.circular(6.0704197884 * fem),
                                ),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: SizedBox(
                                    width: 84.48 * fem,
                                    height: 125.46 * fem,
                                    child: Image.network(
                                      borrowedBook.book.fields.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0 * fem, 11 * fem, 0 * fem, 11 * fem),
                                width: 193 * fem,
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 10 * fem),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 6 * fem),
                                            child: Text(
                                              borrowedBook.book.fields.bookTitle,
                                              style: TextStyle(
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w600,
                                                height: 1.4285714286 * ffem / fem,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'by: ${borrowedBook.book.fields.bookAuthors}',
                                            style: TextStyle(
                                              fontSize: 12 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5 * ffem / fem,
                                              color: Color(0xff818181),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 24 * fem,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 57 * fem,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(0xff3fbcfc),
                                              borderRadius: BorderRadius.circular(999 * fem),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Fantasy',
                                                style: TextStyle(
                                                  fontSize: 10 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.6 * ffem / fem,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 4 * fem),
                                          Container(
                                            width: 78 * fem,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(0xff3fbcfc),
                                              borderRadius: BorderRadius.circular(999 * fem),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Young Adult',
                                                style: TextStyle(
                                                  fontSize: 10 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.6 * ffem / fem,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 4 * fem),
                                          Container(
                                            width: 50 * fem,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color(0xff3fbcfc),
                                              borderRadius: BorderRadius.circular(999 * fem),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Fiction',
                                                style: TextStyle(
                                                  fontSize: 10 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.6 * ffem / fem,
                                                  color: Color(0xffffffff),
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
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 48 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 18 * fem, 0 * fem),
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                                      child: Text(
                                        'Tanggal Peminjaman ',
                                        style: TextStyle(
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3333333333 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      borrowedBook.borrowDate as String,
                                      style: TextStyle(
                                        fontSize: 16 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5 * ffem / fem,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
                                      child: Text(
                                        'Tanggal Pengembalian ',
                                        style: TextStyle(
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3333333333 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      borrowedBook.returnDate as String,
                                      style: TextStyle(
                                        fontSize: 16 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5 * ffem / fem,
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
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 10 * fem),
                          child: Text(
                            'Pengembalian Buku',
                            style: TextStyle(
                              fontSize: 12 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.3333333333 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 265 * fem),
                          child: Text(
                            'Buku ini harus dikembalikan dengan keadaan Sama seperti semula',
                            style: TextStyle(
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.4285714286 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 3 * fem, 0 * fem),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(78.17 * fem, 12 * fem, 75.93 * fem, 12 * fem),
                        width: double.infinity,
                        height: 40 * fem,
                        decoration: BoxDecoration(
                          color: Color(0xff2a4cf1),
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 9.4 * fem, 0 * fem),
                              width: 13.5 * fem,
                              height: 13.5 * fem,
                              child: Image.network(
                                'assets/icons/check-square-fill.png',
                                width: 13.5 * fem,
                                height: 13.5 * fem,
                              ),
                            ),
                            Container(
                              width: 110 * fem,
                              height: double.infinity,
                              child: Center(
                                child: Text(
                                  'Kembalikan Buku',
                                  style: TextStyle(
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3333333333 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
