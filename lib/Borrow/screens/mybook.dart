 import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readhub/Borrow/models/borrowed_book.dart';
import 'package:readhub/together/style/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/Borrow/widgets/my_book_card.dart';
import 'package:readhub/together/widgets/navbar.dart';

class MyBookScreen extends StatefulWidget {
  const MyBookScreen({super.key});

  @override
  State<MyBookScreen> createState() => _MyBookScreenState();
}


class _MyBookScreenState extends State<MyBookScreen> {

  Future<List<BorrowedBook>> fetchProduct(request) async {
    var response = await request.get(
      'https://readhub-c13-tk.pbp.cs.ui.ac.id/borrow_flow/get_borrowed_book_json/'
    );
    List<BorrowedBook> listProduct = [];
    for (var d in response) {
      if (d != null) {
        listProduct.add(BorrowedBook.fromJson(d));
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
        title: Text(
          'My Book',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.5,
            color: Warna.white,
          ),
          
        ),
        backgroundColor: Warna.blue,
        foregroundColor: Warna.white,
        automaticallyImplyLeading: false,
        centerTitle: true, 
      ),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else if(snapshot.data!.length == 0){
            return Stack(
                children: [
                  ListView(
                    children: [
                      Container(
                        height: 350,  // Set an appropriate height for the container
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/YourBook.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      // SizedBox(height: 28.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 56.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: Text(
                                  'You currently have no books.',
                                  style: GoogleFonts.poppins(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                    color: Warna.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              );
          } else {
              return Stack(
                children: [
                  ListView(
                    children: [
                      Container(
                        height: 350,  // Set an appropriate height for the container
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/YourBook.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      // SizedBox(height: 28.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) {
                            return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
                          child: MyBookCard(borrowedBook: snapshot.data![index])
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(index: 3),
    );
  }
}