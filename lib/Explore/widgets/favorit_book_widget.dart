import 'package:flutter/material.dart';
import 'package:readhub/together/style/colors.dart';
import 'dart:convert';
//import 'package:readhub/models/book.dart';
import 'package:readhub/Explore/models/bookFavorit.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readhub/Explore/screens/favoritPage.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // Tunggu sampai operasi hapus selesai, kemudian kembali ke page favorit dengan tampilan yang diperbarui.
  await Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const FavoritScreen()),
  );
}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final request = context.watch<CookieRequest>();
    return InkWell(
      child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: screenWidth,
          decoration: BoxDecoration(
            color: Color(0xff23264f),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                decoration: BoxDecoration(
                  color: Warna.backgroundlight,
                  borderRadius: BorderRadius.circular(6.0704197884),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 84,
                    height: 128,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: NetworkImage(bookFavorit.books.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                width: screenWidth - screenWidth / 2.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      width: screenWidth - 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Text(
                              bookFavorit.books.bookTitle,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "by: ${bookFavorit.books.bookAuthors.length > 30 ? bookFavorit.books.bookAuthors.substring(0, 30) + '...' : bookFavorit.books.bookAuthors}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              color: Color(0xff818181),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle button press action
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Berhasil menghapus buku ${bookFavorit.books.bookTitle}!"),
                            ));
                        _deleteBook(context, request, bookFavorit);
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(17.5, 8, 17.5, 8),
                        width: 120,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Warna.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'Delete',
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
    ])));
  }
}



class BookListView extends StatelessWidget {
  final List<BookFavorit> books;

  BookListView({required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8.0, bottom: 16.0), // Menambahkan jarak atas dan bawah pada seluruh ListView
      scrollDirection: Axis.vertical,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0), // Menambahkan jarak atas dan bawah antar item
          child: BookFavoritWidget(bookFavorit: books[index]),
        );
      },
    );
  }
}

