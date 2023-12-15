import 'package:flutter/material.dart';
import 'package:readhub/Community/models/forum.dart';
import 'package:readhub/Home/models/user.dart';
import 'package:readhub/together/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/together/widgets/navbar.dart';
import 'package:readhub/Home/screens/home.dart';
import 'package:readhub/Explore/screens/explore.dart';
import 'package:readhub/Borrow/screens/mybook.dart';
import 'package:readhub/Home/screens/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readhub/together/models/book.dart';
import 'package:readhub/Explore/widgets/book_widget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController searchController = TextEditingController();
  String selectedCategory = 'All Categories';
  List<Book> myBooks = []; // Deklarasikan variabel di luar ListView.builder
  List<Book> filteredProducts = [];
  List<Book> childrens = []; 
  List<String> genres = ['All Categories'];
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

  // void filterByCategory() {
  //   if (selectedCategory == 'All Categories') {
  //     setState(() {
  //       filteredProducts = myBooks;
  //     });
  //   } else {
  //     List<Book> categoryProducts = myBooks
  //         .where((product) => product.fields.genres.split('|').contains(selectedCategory))
  //         .toList();
  //     setState(() {
  //       filteredProducts = categoryProducts;
  //     });
  //   }
  // }


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

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Warna.background,
      bottomNavigationBar: BottomNavBar(index: 0),
      body: SingleChildScrollView(
        child: Padding(
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
                              margin: EdgeInsets.fromLTRB(0, 0, screenWidth/9, 0),
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
                                    userlogin,
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
                                  fontSize: 24,
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
                      TextButton(
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
                    ],
                  ),
                ),
                SizedBox(height: 32),
               Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Popular Books",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Warna.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
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
                                child: BookListView(books: filteredProducts),);
                        }}}
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
