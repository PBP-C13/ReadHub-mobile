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
import 'package:readhub/screens/flow/detail.dart';


class FavoritScreen extends StatefulWidget {
  const FavoritScreen({super.key});

  @override
  State<FavoritScreen> createState() => _FavoritScreenState();
}

// class Favorit {
//   final Book book; //objek buku yg difavorit
//   final String description;

//   Favorit(this.book, this.description);
// }


class _FavoritScreenState extends State<FavoritScreen> {
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
                  SliverPadding(
                    padding: EdgeInsets.all(16.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // ... (Input dan Tombol Cari)
                      ]),
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
                        SizedBox(height: 35),
                        
                        Container(
                          height: 280, // Sesuaikan tinggi container dengan kebutuhan
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  // Get the selected book
                                    Book selectedBook = snapshot.data![index];

                                    // Navigate to the second page and pass the selected book's data
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(book: selectedBook),
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
                                                    borderRadius: BorderRadius.circular(10.0), // Sesuaikan nilai border radius
                                                    child: CachedNetworkImage(
                                                      imageUrl: "${snapshot.data![index].fields.imageUrl}",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              
                                              right: 4, // Sesuaikan dengan posisi yang Anda inginkan
                                              top: 4, // Sesuaikan dengan posisi yang Anda inginkan
                                              child: Align(
                                                alignment: Alignment.topRight,
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
                                              padding: EdgeInsets.symmetric(horizontal: 10), // Tambahkan padding di sini
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                              constraints: const BoxConstraints(
                                                maxWidth: 135,
                                              ),
                                              child: Text(
                                                "${snapshot.data![index].fields.bookTitle.length > 25 ? snapshot.data![index].fields.bookTitle.substring(0, 25) + '...' : snapshot.data![index].fields.bookTitle}",
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
                                              padding: EdgeInsets.symmetric(horizontal: 10), // Tambahkan padding di sini
                                              child: Text(
                                                "${snapshot.data![index].fields.bookAuthors.length > 20 ? snapshot.data![index].fields.bookAuthors.substring(0, 20) + '...' : snapshot.data![index].fields.bookAuthors}",
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
                            },
                          ),
                    ),])
                  ),
                ],
              );
                  }
              }
          }));
        }
      }