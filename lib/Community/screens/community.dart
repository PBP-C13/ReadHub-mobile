import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readhub/Community/screens/create_forum.dart';
import 'package:readhub/together/widgets/navbar.dart';
import 'package:readhub/Community/widgets/community_forum.dart';
import 'package:readhub/Community/models/forum.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/together/style/colors.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String currentGenre = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        switch (_tabController.index) {
          case 0:
            currentGenre = 'All';
            break;
          case 1:
            currentGenre = 'Fantasy';
            break;
          case 2:
            currentGenre = 'Romance';
            break;
        }
      }
    );
  }
}


  Future<List<Forum>> fetchProduct(request) async {
    var response = await request.get('https://readhub-c13-tk.pbp.cs.ui.ac.id/community/get-product/');
    
    List<Forum> listProduct = [];
    for (var d in response) {
      if (d != null) {
        Forum forum = Forum.fromJson(d);
        if (currentGenre == 'All' || forum.bookGenre.contains(currentGenre)) {
          listProduct.add(forum);
        }
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: Warna.background,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 1,
        elevation: 0.0,
        centerTitle: true, 
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
       bottom: TabBar(
          controller: _tabController,
          labelColor: Warna.white,
          unselectedLabelColor: Warna.semiWhite,
          labelStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600, // SemiBold
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600, // Medium
          ),
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Fantasy'),
            Tab(text: 'Romance'),
          ],
        indicator: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white, width: 3.0)),
        ),
        indicatorColor: Colors.transparent, // Set indicatorColor ke transparent

        ), systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildTabContent(request),
          buildTabContent(request),
          buildTabContent(request),
        ],
      ),
      bottomNavigationBar: BottomNavBar(index: 2),
    );
  }

  
  Widget buildTabContent(CookieRequest request) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
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
                        int reverseIndex = snapshot.data!.length - 1 - index;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: CommunityForumWidget(
                              forum: snapshot.data![reverseIndex]),
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
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
