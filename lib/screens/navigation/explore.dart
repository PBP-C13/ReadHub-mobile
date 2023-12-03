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


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class BookItem {
  final String imageUrl; // Menyimpan URL gambar
  final String title;   //judul buku
  final String author;  //author

  BookItem(this.imageUrl, this.title, this.author);
}


class _ExploreScreenState extends State<ExploreScreen> {
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
      // appBar: AppBar(
      //   title:
      //       const Text('CATEGORY', style: TextStyle(color: Colors.black)),
      // ),
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
                  slivers: [
                    SliverAppBar(
                      backgroundColor:Warna.blue,
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          "Explore Book",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        background: Image.asset(
                          'assets/images/Community.png', 
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.all(16.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          // Kolom input atau teks sesuai kebutuhan
                          TextField(
                            controller: myController,
                            decoration: InputDecoration(
                              labelText: 'Masukkan judul buku',
                              labelStyle: TextStyle(color: Warna.white),
                              hintStyle: TextStyle(color: Warna.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Warna.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Warna.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Warna.white),
                              ),
                            ),
                            style: TextStyle(color: Warna.white),
                            
                          ),
                          const SizedBox(height: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              // Tambahkan aksi yang ingin dilakukan saat tombol ditekan
                            },
                            child: Text("Cari"),
                          ),
                        ]),
                      ),
                    ),
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250.0,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                          childAspectRatio: 0.7,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Card(
                              color: Warna.lightcyan,
                              elevation: 4.0,
                              margin: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 150.0,
                                      child: Image.network(
                                        "${snapshot.data![index].fields.imageUrl}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    Text(
                                      "${snapshot.data![index].fields.bookTitle.length > 25 ? snapshot.data![index].fields.bookTitle.substring(0, 25) + '...' : snapshot.data![index].fields.bookTitle}",
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      "${snapshot.data![index].fields.bookAuthors.length > 25 ? snapshot.data![index].fields.bookAuthors.substring(0, 25) + '...' : snapshot.data![index].fields.bookAuthors}",
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                             // Navigate to the second page when the button is pressed
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => DetailScreen()),
                                              );
                                            },
                                            child: Text(
                                              "Detail Book",
                                              style: const TextStyle(
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.0), // Jarak antara tombol
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Aksi yang ingin dilakukan saat tombol kedua ditekan
                                            },
                                            child: Text(
                                              "Add Favorit",
                                              style: const TextStyle(
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                          ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
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