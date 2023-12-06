import 'package:flutter/material.dart';
import 'package:readhub/screens/other/create_forum.dart';
import 'package:readhub/widgets/navbar.dart';
import 'package:readhub/widgets/community_forum.dart';
import 'package:readhub/models/forum.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/styles/colors.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {

  Future<List<Forum>> fetchProduct(request) async {
    var response = await request.get(
      'https://readhub-c13-tk.pbp.cs.ui.ac.id/community/get-product/'
    );

    List<Forum> listProduct = [];
    for (var d in response) {
      if (d != null) {
        listProduct.add(Forum.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: Warna.background,
      appBar: AppBar(
        title: Text(
          'Community',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.5,
            color: Warna.white,
          ),
        ),
        backgroundColor: Warna.backgrounddark,
        foregroundColor: Warna.white,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data produk.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return Stack(
                children: [
                  ListView(
                    children: [
                      Container(
                        color: Warna.blue,
                        width: screenWidth,
                        height: screenHeight / 3.8,
                        child: Image.asset(
                          'assets/images/Community.png', 
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 28.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) {
                           return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: CommunityForumWidget(forum: snapshot.data![index]),
                        );
                      },
                    ),
                    ],
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height / 48,
                    right: 28,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateForum(), 
                        ));
                      },
                      child: Icon(Icons.add, color: Colors.white),
                      backgroundColor: Warna.cyan,
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(index: 2),
    );
  }
}