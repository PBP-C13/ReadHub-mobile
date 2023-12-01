import 'package:flutter/material.dart';
import 'package:readhub/widgets/navbar.dart';
import 'package:readhub/widgets/shop_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/styles/colors.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<ShopItem> items = [
    ShopItem("Home", Icons.home, Warna.blue),
    ShopItem("Community", Icons.people, Warna.blue),
    ShopItem("Explore", Icons.explore, Warna.blue),
    ShopItem("My Book", Icons.book, Warna.blue),
    ShopItem("Profile", Icons.person, Warna.blue),
    ShopItem("Detail", Icons.details, Warna.blue),
    ShopItem("Borrow Book", Icons.library_books, Warna.blue),
    ShopItem("Onboarding", Icons.directions_run, Warna.blue),
    ShopItem("Logout", Icons.logout, Warna.cyan), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
            'Navigation',
          ),
          backgroundColor: Warna.blue,
          foregroundColor: Warna.background,
          automaticallyImplyLeading: false, 
        ),
        backgroundColor: Warna.background,
        bottomNavigationBar: BottomNavBar(index: 4),
          // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
          body: SingleChildScrollView(
            // Widget wrapper yang dapat discroll
            child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'ReadHub', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Warna.white,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item) {
                  // Iterasi untuk setiap item
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
