import 'package:flutter/material.dart';
import 'package:readhub/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/widgets/navbar.dart';
import 'package:readhub/screens/navigation/home.dart';
import 'package:readhub/screens/navigation/explore.dart';
import 'package:readhub/screens/navigation/mybook.dart';
import 'package:readhub/screens/navigation/profile.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class BookItem {
  final String name;
  final IconData icon;

  BookItem(this.name, this.icon);
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.background,
      bottomNavigationBar: BottomNavBar(index: 1),
      appBar: AppBar(
        title:
            const Text('CATEGORY', style: TextStyle(color: Colors.black)),
      ),
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
                        'Search Book', // Text yang menandakan toko
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                      // children: items.map((ShopItem item) {
                      //   // Iterasi untuk setiap item
                      //   return ShopCard(item);
                      // }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }