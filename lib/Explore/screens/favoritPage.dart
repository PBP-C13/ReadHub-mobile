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
  final CookieRequest? request; // Tambahkan parameter request
  const FavoritScreen({this.request, Key? key}) : super(key: key);
  @override
  State<FavoritScreen> createState() => _FavoritScreenState();
}


class _FavoritScreenState extends State<FavoritScreen> {
  List<BookFavorit> myBooks = []; // Deklarasikan variabel di luar ListView.builder
  List<String> genres = ['All Categories'];
  String selectedCategory = 'All Categories';
  List<BookFavorit> filteredProducts = [];
  late CookieRequest request; // Deklarasikan variabel request di dalam State
  TextEditingController searchController  = TextEditingController();

  Future<List<BookFavorit>> fetchProduct(request) async {
    var response = await request.get(

      'https://readhub-c13-tk.pbp.cs.ui.ac.id/category/json/'

    );
    List<BookFavorit> listProduct = [];

    for (var d in response) {
      if (d != null) {
        listProduct.add(BookFavorit.fromJson(d));
      }
    }
    myBooks = listProduct;
    return listProduct;
  }

  void updateCategories() {
    Set<String> uniqueCategories = {'All Categories'};
    for (var product in myBooks) {
      for(var gen in product.books.genres.split('|')){
        if(gen=="Romance" || gen=="Fantasy" || gen=="Classics" || gen=="Historical" || gen=="Childrens"){
          uniqueCategories.add(gen);}
      }
    }
    setState(() {
      genres = uniqueCategories.toList();
      genres.sort(); // Sort the categories
    });
  }

 @override
  void initState() {
    super.initState();
     request = widget.request ?? CookieRequest();  // Inisialisasi request dengan nilai dari widget
    fetchProduct(request).then((products) {
      setState(() {
        myBooks = products;
        filteredProducts = myBooks;
        updateCategories(); // Update the category list
      });
    });
  }
  
  void filterByCategory() {
    if (selectedCategory == 'All Categories') {
      setState(() {
        filteredProducts = myBooks;
      });
    } else {
      List<BookFavorit> categoryProducts = myBooks
          .where((product) => product.books.genres.split('|').contains(selectedCategory))
          .toList();
      setState(() {
        filteredProducts = categoryProducts;
      });
    }
  }

    void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = myBooks;
      });
      return;
    }

    List<BookFavorit> dummyListData = [];
    myBooks.forEach((item) {
      if (item.books.bookTitle.toLowerCase().contains(query.toLowerCase()) || item.books.bookAuthors.toLowerCase().contains(query.toLowerCase())) {
        dummyListData.add(item);
      }
    });

    setState(() {
      filteredProducts = dummyListData;
    });

  }


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: Warna.background,
      appBar: AppBar(
        title: Text(
          'Favorit Book',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.5,
            color: Warna.white,
          ),
        ),
        backgroundColor: Warna.background,
        iconTheme: IconThemeData(color: Colors.white),
        leading: Padding(
        padding: EdgeInsets.only(left: 20),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Kembali ke page sebelumnya (profil) tanpa menambahkannya ke tumpukan navigasi.
              Navigator.of(context).pop();
            },
          ),
        ),
        foregroundColor: Warna.white,
        centerTitle: true,
      ),
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
                                              controller: searchController,
                                              onChanged: filterSearchResults,
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
                                                  selectedCategory = value;
                                                  filterByCategory(); // Filter products by category
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
                        SizedBox(height: 15),
                        Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0), // Tambahkan padding ke kanan dan kiri
                        child: Column(
                          children: [
                            Text(
                              "Favorit Books",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Warna.white,
                              )
                            ),
                            SizedBox(height: 10),
                            Container(
                              // Container atas
                              height: 400,
                              child: BookListView(books: filteredProducts),
                            ),

                        ])
                    ),
                  ],
                    ))]);
                
                  }
              }
          }));
        }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

}