import 'package:flutter/material.dart';
import 'package:readhub/together/style/colors.dart';


class BookItem {
  final String imageUrl; // Menyimpan URL gambar
  final String title;   //judul buku
  final String author;  //author

  BookItem(this.imageUrl, this.title, this.author);
}

class BookCard extends StatelessWidget {
  final BookItem item;

  const BookCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Warna.backgroundlight, 
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.title}!")));
          // Navigate ke route yang sesuai (tergantung jenis tombol)


        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), // Set the border radius here
          ),
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}