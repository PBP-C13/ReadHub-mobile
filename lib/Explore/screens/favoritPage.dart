import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readhub/together/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/Explore/widgets/favorit_book_widget.dart';
import 'package:readhub/together/widgets/navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readhub/Explore/models/bookFavorit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:readhub/Detail/screens/detail_book.dart';

class FavoritScreen extends StatefulWidget {
  const FavoritScreen({super.key});
  @override
  State<FavoritScreen> createState() => _FavoritScreenState();
}


class _FavoritScreenState extends State<FavoritScreen> {
  List<BookFavorit> myBooks = []; // Deklarasikan variabel di luar ListView.builder
  Future<List<BookFavorit>> fetchProduct(request) async {
    var response = await request.get(

      'https://readhub-c13-tk.pbp.cs.ui.ac.id/category/json/'

    );
    List<BookFavorit> listProduct = [];
    print(response);

    for (var d in response) {
      if (d != null) {
        listProduct.add(BookFavorit.fromJson(d));
      }
    }
    myBooks = listProduct;
    print(listProduct);
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: Warna.background,
      bottomNavigationBar: BottomNavBar(index: 1),
      body: FutureBuilder(
          future: fetchProduct(request),
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
                  slivers: [
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
                            "Favorit",
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
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        ])
                    ),
                    
                    SliverGrid(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                          childAspectRatio: 0.59,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return BookFavoritWidget(bookFavorit: myBooks[index]);    
                          },
                          childCount: snapshot.data!.length,
                        ),
                      ),
                  ],
                );
                  }
              }
          }));
        }
      }