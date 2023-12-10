import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'your_love_form_widget.dart'; // Sesuaikan dengan nama file yang sesuai
import 'package:readhub/styles/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readhub/models/book.dart';
import 'package:readhub/screens/flow/detail_book.dart';


class BookWidget extends StatelessWidget {
  final Book book;

  BookWidget({required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(book: book),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: 152.0,
        decoration: BoxDecoration(
          color: Warna.backgroundlight,
          borderRadius: BorderRadius.circular(18.3132534027),
          boxShadow: const [
            BoxShadow(
              color: Color(0x05a3a3a3),
              offset: Offset(3.6626505852, 3.6626505852),
              blurRadius: 9.1566267014,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Warna.backgroundlight,
                borderRadius: BorderRadius.circular(9.99081707),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 137.91,
                        height: 185,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: "${book.fields.imageUrl}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return YourLoveFormWidget();
                          //   },
                          // );
                        },
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: Image.asset(
                            'assets/icons/love.png',
                            width: 32,
                            height: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Warna.backgroundlight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                    constraints: const BoxConstraints(
                      maxWidth: 135,
                    ),
                    child: Text(
                      "${book.fields.bookTitle.length > 25 ? book.fields.bookTitle.substring(0, 25) + '...' : book.fields.bookTitle}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        height: 1.3333333333,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "${book.fields.bookAuthors != null && book.fields.bookAuthors!.length > 20 ? book.fields.bookAuthors!.substring(0, 20) + '...' : book.fields.bookAuthors ?? ''}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        height: 1.6,
                        color: Color(0xffb6b6b6),
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

class BookListView extends StatelessWidget {
  final List<Book> books;

  BookListView({required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        return BookWidget(book: books[index]);
      },
    );
  }
}
