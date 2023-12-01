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
        'http://localhost:8000/json/');
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
      appBar: AppBar(
        title:
            const Text('CATEGORY', style: TextStyle(color: Colors.black)),
      ),
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
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                    Image.network(
                                    "${snapshot.data![index].fields.imageUrl}",
                                    width: 50.0,
                                    height: 50.0,
                                    // Atur properti lain sesuai kebutuhan
                                  ),
                                  SizedBox(height: 8.0), // Spasi antara gambar dan teks
                                  Text(
                                  "${snapshot.data![index].fields.bookTitle}",
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Warna.white,
                                      fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${snapshot.data![index].fields.bookAuthors}",
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Warna.white,
                                      fontWeight: FontWeight.bold,
                                      ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                      "${snapshot.data![index].fields.genres}",
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Warna.white,
                                      fontWeight: FontWeight.bold,
                                  ),
                                  )
                              ],
                              ),
                          ));
                  }
              }
          }));
        }
      }