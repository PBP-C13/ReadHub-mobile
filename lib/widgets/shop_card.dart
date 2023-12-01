import 'package:flutter/material.dart';
import 'package:readhub/screens/auth/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readhub/screens/auth/onboarding.dart';
import 'package:readhub/screens/navigation/community.dart';
import 'package:readhub/screens/navigation/explore.dart';
import 'package:readhub/screens/navigation/home.dart';
import 'package:readhub/screens/navigation/mybook.dart';
import 'package:readhub/screens/navigation/profile.dart';

class ShopItem {
  final String name;
  final IconData icon;
   final Color color;

  ShopItem(this.name, this.icon, this.color);
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor
  
   @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: item.color, 
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () async {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          // Navigate ke route yang sesuai (tergantung jenis tombol)
          if (item.name == "Home") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Homescreen()),
            );

          } else if (item.name == "Community") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CommunityScreen()));

          } else if (item.name == "Explore") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ExploreScreen()));

          } else if (item.name == "My Book") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyBookScreen()));

          } else if (item.name == "Profile") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()));

          } else if (item.name == "Onboarding") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Onboarding()));

          } else if (item.name == "Logout") {
            final response =
                await request.logout("http://127.0.0.1:8000/auth/logout/");
            String message = response["message"];
            if (response['status']) {
              String uname = response["username"];
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Sampai jumpa, $uname."),
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message"),
              ));
            }
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
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