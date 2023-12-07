import 'package:flutter/material.dart';
import 'package:readhub/models/borrowed_book.dart';
import 'package:readhub/styles/colors.dart';

class MyBookCard extends StatelessWidget {
   final BorrowedBook borrowedBook;
  MyBookCard({Key? key, required this.borrowedBook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.fromLTRB(16, 20, 13, 20),
      width: 400,
      height: 600,
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
              margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                    width: screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                          width: screenWidth,
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
                                width: 193,
                                height: 200,
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
                                              style: TextStyle(
                                                fontSize: 14 ,
                                                fontWeight: FontWeight.w600,
                                                height: 1.4285714286 ,
                                                color: Color(0xffffffff),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'by: ${borrowedBook.book.bookAuthors}',
                                            style: TextStyle(
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
                                      width: screenWidth,
                                      height: 24,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 57,
                                            height: screenHeight,
                                            decoration: BoxDecoration(
                                              color: Color(0xff3fbcfc),
                                              borderRadius: BorderRadius.circular(999),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Fantasy',
                                                style: TextStyle(
                                                  fontSize: 10 ,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.6 ,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Container(
                                            width: 78,
                                            height: screenHeight,
                                            decoration: BoxDecoration(
                                              color: Color(0xff3fbcfc),
                                              borderRadius: BorderRadius.circular(999),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Young Adult',
                                                style: TextStyle(
                                                  fontSize: 10 ,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.6 ,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Container(
                                            width: 50,
                                            height: screenHeight,
                                            decoration: BoxDecoration(
                                              color: Color(0xff3fbcfc),
                                              borderRadius: BorderRadius.circular(999),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Fiction',
                                                style: TextStyle(
                                                  fontSize: 10 ,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.6 ,
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
                          width: screenWidth,
                          height: 48,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 18, 0),
                                height: screenHeight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Text(
                                        'Tanggal Peminjaman ',
                                        style: TextStyle(
                                          fontSize: 12 ,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3333333333 ,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      borrowedBook.borrowDate.toString(),
                                      style: TextStyle(
                                        fontSize: 16 ,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5 ,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: screenHeight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Text(
                                        'Tanggal Pengembalian ',
                                        style: TextStyle(
                                          fontSize: 12 ,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3333333333 ,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      borrowedBook.returnDate.toString(),
                                      style: TextStyle(
                                        fontSize: 16 ,
                                        fontWeight: FontWeight.w600,
                                        height: 1.5 ,
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
                            style: TextStyle(
                              fontSize: 12 ,
                              fontWeight: FontWeight.w600,
                              height: 1.3333333333 ,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 265),
                          child: Text(
                            'Buku ini harus dikembalikan dengan keadaan Sama seperti semula',
                            style: TextStyle(
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
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 3, 0),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(78.17, 12, 75.93, 12),
                        width: screenWidth,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xff2a4cf1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
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
                            Container(
                              width: 110,
                              height: screenHeight,
                              child: Center(
                                child: Text(
                                  'Kembalikan Buku',
                                  style: TextStyle(
                                    fontSize: 12 ,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3333333333 ,
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
