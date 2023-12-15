import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'your_love_form_widget.dart'; // Sesuaikan dengan nama file yang sesuai
import 'package:readhub/together/style/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:readhub/models/book.dart';
import 'package:readhub/Detail/screens/detail_book.dart';
import 'package:readhub/Explore/models/bookFavorit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readhub/Explore/screens/favoritPage.dart';

class BookFavoritWidget extends StatelessWidget {
  final BookFavorit bookFavorit;

  BookFavoritWidget({required this.bookFavorit});

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

  Future<void> _deleteBook(BuildContext context, CookieRequest request, BookFavorit bookFavorit) async {
    await request.postJson(
      'https://readhub-c13-tk.pbp.cs.ui.ac.id/category/delete-favorit-flutter/${bookFavorit.books.id}/',
      jsonEncode({
        "id": bookFavorit.books.id,
      }),
    );
    Navigator.of(context).push(_createRoute(const FavoritScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DetailScreen(book: bookFavorit.books),
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        //width: 152.0,
        height:150,
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
                            imageUrl: "${bookFavorit.books.imageUrl}",
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
                      child: GestureDetector(
                        onTap: () {
                          // Handle button press action
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Berhasil menghapus buku ${bookFavorit.books.bookTitle}!"),
                              ));
                          _deleteBook(context, request, bookFavorit);
                        },
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: Icon(Icons.delete, color: Colors.red),
                        ),
                      )
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
                      "${bookFavorit.books.bookTitle.length > 25 ? bookFavorit.books.bookTitle.substring(0, 25) + '...' : bookFavorit.books.bookTitle}",
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
                      "${bookFavorit.books.bookAuthors != null && bookFavorit.books.bookAuthors!.length > 20 ? bookFavorit.books.bookAuthors!.substring(0, 20) + '...' : bookFavorit.books.bookAuthors ?? ''}",
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
  final List<BookFavorit> books;

  BookListView({required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        return BookFavoritWidget(bookFavorit: books[index]);
      },
    );
  }
}
