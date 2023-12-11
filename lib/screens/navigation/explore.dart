import 'package:flutter/material.dart';
import 'package:readhub/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/widgets/navbar.dart';
import 'package:readhub/screens/navigation/home.dart';
import 'package:readhub/screens/navigation/explore.dart';
import 'package:readhub/screens/navigation/mybook.dart';
import 'package:readhub/screens/navigation/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readhub/models/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:readhub/screens/flow/detail_book.dart';
import 'package:readhub/widgets/book_widget.dart';



class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}


class _ExploreScreenState extends State<ExploreScreen> {
  List<Book> myBooks = [];
  List<Book> fantasy = []; 
  List<Book> romance = []; 
  String selectedGenre = "All Books"; // Nilai default
  List<String> genres = ["All Books", "Fantasy", "Romance"];


  Future<List<Book>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'https://readhub-c13-tk.pbp.cs.ui.ac.id/json/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Book> list_product = [];
    for (var d in data) {
        if (d != null) {
            list_product.add(Book.fromJson(d));
        }
    }
    myBooks = list_product;

    for (var book in list_product) {
      // Check if the book has at least one common genre with the target book
      List<String> commonGenres = book.fields.genres.split('|')
          .where((genre) =>
              book.fields.genres.split('|').contains("Fantasy"))
          .toList();

      if (commonGenres.isNotEmpty) {
        fantasy.add(book);
      }
    }

    for (var book in list_product) {
      // Check if the book has at least one common genre with the target book
      List<String> commonGenres = book.fields.genres.split('|')
          .where((genre) =>
              book.fields.genres.split('|').contains("Romance"))
          .toList();

      if (commonGenres.isNotEmpty) {
        romance.add(book);
      }
    }

    return list_product;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.background,
      bottomNavigationBar: BottomNavBar(index: 1),
      body: FutureBuilder(
          future: fetchProduct(),
          builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
              } else {
                  if (!snapshot.hasData) {
                  return const Column(
                      children: [
                      Text(
                          "Tidak ada data produk.",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                      ],
                  );
              } else {
                TextEditingController myController = TextEditingController();
                return CustomScrollView(
                  slivers:[
                    SliverToBoxAdapter(
                    child: Container(
                      height: 280.0,
                      decoration: BoxDecoration(
                        color: Warna.blue,
                        image: DecorationImage(
                          image: AssetImage('assets/images/Explorepage.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        // child: Padding(
                          // padding: EdgeInsets.only(bottom: 30),
                          child: Text(
                            "Explore",
                            style: GoogleFonts.poppins(
                              fontSize: 56,
                              fontWeight: FontWeight.bold,
                              color: Warna.white,
                            ),
                          // ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          height: 64,
                          child: Stack(
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                      padding: EdgeInsets.fromLTRB(13, 15, 36, 13),
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xff292c4f),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: 28,
                                            height: 28,
                                            child: Icon(
                                              Icons.search, 
                                              color: Colors.white, 
                                              size: 28, 
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            child: TextField(
                                              style: TextStyle(color: Colors.white), // Atur warna teks menjadi putih
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder: InputBorder.none,
                                                contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 13.0), // Sesuaikan sesuai kebutuhan
                                                hintText: 'Type here', // Tambahkan teks petunjuk jika diperlukan
                                                hintStyle: TextStyle(color: Colors.grey),
                                                alignLabelWithHint: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: TextButton(
                                      onPressed: () {
                                        showMenu(
                                              context: context,
                                              position: RelativeRect.fromLTRB(250, 250, 250, 250),
                                              items: genres.map((String genre) {
                                                return PopupMenuItem<String>(
                                                  value: genre,
                                                  child: Text(genre),
                                                );
                                              }).toList(),
                                            ).then((value) {
                                              if (value != null) {
                                                setState(() {
                                                  selectedGenre = value;
                                                });
                                              }
                                            });
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Container(
                                        width: 56,
                                        height: 56,
                                        child: ClipRRect(
                                          child: Image.asset(
                                            'assets/icons/Filter.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 35),
                        Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0), // Tambahkan padding ke kanan dan kiri
                        child: Column(
                          children: [
                            Text(
                              "All Books",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Warna.white,
                              )
                            ),
                            SizedBox(height: 10),
                            Container(
                              // Container atas
                              height: 290,
                              child: BookListView(books: myBooks),
                            ),
                            SizedBox(height: 40),
                            Text(
                              "Romance",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Warna.white,
                              )
                            ),
                            SizedBox(height: 10),
                            Container(
                              // Container bawah
                              height: 290,
                              child: BookListView(books: romance),
                            ),
                            SizedBox(height: 40),
                            
                            Text(
                              "Fantasy",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Warna.white,
                              )
                            ),
                            SizedBox(height: 10),
                            Container(
                              // Container bawah
                              height: 290,
                              child: BookListView(books: fantasy),
                            ),
                          ],
                        ),
                      ),
                      ],
                    )
                  ),
                ],
              );
                  }
              }
          }));
        }
      }