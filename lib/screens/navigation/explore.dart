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
                TextEditingController myController = TextEditingController();
                  return Column(
                    children: [
                      // Bagian Pertama: Teks dan Kolom Input
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "Search Book",
                              style: TextStyle(
                                color: Warna.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            // Tambahkan kolom input atau teks sesuai kebutuhan
                            // Contoh:
                            TextField(
                              controller: myController,
                              decoration: InputDecoration(
                                labelText: 'Masukkan judul buku',
                                labelStyle: TextStyle(color: Colors.white), // Warna label
                                hintStyle: TextStyle(color: Colors.white), // Warna hint text
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white), // Warna garis pinggir
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white), // Warna garis pinggir saat aktif
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white), // Warna garis pinggir saat fokus
                                ),
                              ),
                              style: TextStyle(color: Colors.white), // Warna teks input
                            ),
                            const SizedBox(height: 8.0),
                            
                            ElevatedButton(
                              onPressed: () {
                                // Tambahkan aksi yang ingin dilakukan saat tombol ditekan
                              },
                              child: Text("Cari"),
                            ),
                          ],
                        ),
                      ),

                      // Bagian Kedua: GridView dengan Card-Card Buku
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250.0,
                            crossAxisSpacing: 1.0,
                            mainAxisSpacing: 1.0,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Card(
                            color: Warna.backgroundlight,
                            elevation: 4.0,
                            margin: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: double.infinity, // Agar gambar mengisi lebar Card
                                            height: 150.0, // Sesuaikan tinggi gambar sesuai kebutuhan
                                            child: Image.network(
                                              "${snapshot.data![index].fields.imageUrl}",
                                              fit: BoxFit.cover, // Agar gambar diatur sesuai dimensi kotak
                                            ),
                                          ),
                                        SizedBox(height: 16.0),
                                        Text(
                                          "${snapshot.data![index].fields.bookTitle}",
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          "${snapshot.data![index].fields.bookAuthors.length > 25 ? snapshot.data![index].fields.bookAuthors.substring(0, 25) + '...' : snapshot.data![index].fields.bookAuthors}",
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                  }
              }
          }));
        }
      }