import 'package:flutter/material.dart';
import 'package:readhub/together/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/together/widgets/navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readhub/together/models/book.dart';
import 'package:readhub/Explore/widgets/book_widget.dart';



class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}


class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController searchController = TextEditingController();
  List<Book> filteredProducts = [];
  String selectedCategory = 'All Categories';
  List<Book> myBooks = [];
  List<Book> fantasy = []; 
  List<Book> romance = [];
  List<Book> history = [];
  List<Book> classic = [];
  List<Book> childrens = []; 
  List<String> genres = ['All Categories'];

  @override
  void initState() {
    super.initState();
    fetchProduct().then((products) {
      setState(() {
        myBooks = products;
        filteredProducts = myBooks;
        updateCategories(); // Update the category list
      });
    });
  }

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

    //FANTASY BOOK
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

    //ROMANCE
    for (var book in list_product) {
      List<String> commonGenres = book.fields.genres.split('|')
          .where((genre) =>
              book.fields.genres.split('|').contains("Romance"))
          .toList();

      if (commonGenres.isNotEmpty) {
        romance.add(book);
      }
    }

    //HISTORICAL
    for (var book in list_product) {
      List<String> commonGenres = book.fields.genres.split('|')
          .where((genre) =>
              book.fields.genres.split('|').contains("Historical"))
          .toList();

      if (commonGenres.isNotEmpty) {
        history.add(book);
      }
    }

    //Children
    for (var book in list_product) {
      List<String> commonGenres = book.fields.genres.split('|')
          .where((genre) =>
              book.fields.genres.split('|').contains("Childrens"))
          .toList();

      if (commonGenres.isNotEmpty) {
        childrens.add(book);
      }
    }

    //Fiction
    for (var book in list_product) {
      List<String> commonGenres = book.fields.genres.split('|')
          .where((genre) =>
              book.fields.genres.split('|').contains("Classics"))
          .toList();

      if (commonGenres.isNotEmpty) {
        classic.add(book);
      }
    }

    return list_product;
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = myBooks;
      });
      return;
    }

    List<Book> dummyListData = [];
    myBooks.forEach((item) {
      if (item.fields.bookTitle.toLowerCase().contains(query.toLowerCase()) || item.fields.bookAuthors.toLowerCase().contains(query.toLowerCase())) {
        dummyListData.add(item);
      }
    });

    setState(() {
      filteredProducts = dummyListData;
    });

  }
  
  void updateCategories() {
    Set<String> uniqueCategories = {'All Categories'};
    for (var product in myBooks) {
      for(var gen in product.fields.genres.split('|')){
        if(gen=="Romance" || gen=="Fantasy" || gen=="Classics" || gen=="Historical" || gen=="Childrens"){
          uniqueCategories.add(gen);}
      }
    }
    setState(() {
      genres = uniqueCategories.toList();
      genres.sort(); // Sort the categories
    });
  }

  void filterByCategory() {
    if (selectedCategory == 'All Categories') {
      setState(() {
        filteredProducts = myBooks;
      });
    } else {
      List<Book> categoryProducts = myBooks
          .where((product) => product.fields.genres.split('|').contains(selectedCategory))
          .toList();
      setState(() {
        filteredProducts = categoryProducts;
      });
    }
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
                                      // height: double.infinity,
                                      height: 64, // Fixed height of the container
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
                                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0), // Sesuaikan sesuai kebutuhan
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
                              child: BookListView(books: filteredProducts),
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

                            SizedBox(height: 40),
                            Text(
                              "Historical",
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
                              child: BookListView(books: history),
                            ),

                            SizedBox(height: 40),
                            Text(
                              "Childrens",
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
                              child: BookListView(books: childrens),
                            ),
                            SizedBox(height: 40),
                            Text(
                              "Classics",
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
                              child: BookListView(books: classic),
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}