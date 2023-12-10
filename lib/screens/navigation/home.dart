import 'package:flutter/material.dart';
import 'package:readhub/models/forum.dart';
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
import 'package:readhub/widgets/book_widget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Book> myBooks = []; // Deklarasikan variabel di luar ListView.builder
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
    return list_product;
  }
  

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Warna.background,
      bottomNavigationBar: BottomNavBar(index: 0),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(28, 76, 28, 0), // Padding kiri, atas, kanan menjadi 28, dan atas menjadi 64
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 21),
                      width: double.infinity,
                      height: 68,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 100, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // width: screenWidth - (screenWidth / 2.25),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                                  child: Text(
                                    'Welcome,',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5,
                                      color: Color(0xffb6b6b6),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Arya Wijaya! 👋🏻',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    height: 1.4,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                         Container(
                          width: 64,
                          height: 64, // Set the height and width to the same value for a square shape
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18), // Optional: Add some rounded corners to the container
                          ),
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(28), // Radius to create a circular effect inside the square
                              child: Image.asset(
                                'assets/images/Profile.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 26, 16, 26),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Warna.blue,
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: AssetImage('assets/images/Explore card.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                            constraints: BoxConstraints(
                              maxWidth: 190,
                            ),
                            child: Text(
                              'Explore Buku Favoritmu!',
                              style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                height: 1.3333333333,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ExploreScreen()));
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              width: 112,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xff3fbcfc),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'Explore',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3333333333,
                                    color: Color(0xffffffff),
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
              SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 64,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      padding: EdgeInsets.fromLTRB(18.32, 15, 36, 13),
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
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
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
                  ],
                ),
              ),
              // SizedBox(height: 40),
              // Container(
              // padding: EdgeInsets.symmetric(horizontal: 16.0), // Tambahkan padding ke kanan dan kiri
              // child: Column(
              //   children: [
              //     Text(
              //       "All Books",
              //       style: GoogleFonts.poppins(
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //         color: Warna.white,
              //       )
              //     ),
              //     SizedBox(height: 10),
              //     Container(
              //       // Container atas
              //       height: 290,
              //       child: BookListView(books: myBooks),
              //     ),
              //   ]))
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
                child: FutureBuilder(
                    future: fetchProduct(),
                    builder:  (context, AsyncSnapshot snapshot) {
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
                        return Container(// Container bawah
                              height: 290,
                              child: BookListView(books: myBooks),);
                      }}}
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
