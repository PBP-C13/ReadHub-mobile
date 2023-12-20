import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readhub/Borrow/screens/borrow.dart';
import 'package:readhub/together/style/colors.dart';
import 'package:readhub/Explore/widgets/favorit_form.dart';
import 'package:readhub/together/models/book.dart';
import 'package:readhub/Detail/models/detail.dart';
import 'package:readhub/Detail/widgets/review_card.dart';
import 'package:readhub/Detail/widgets/review_form.dart';
import 'package:readhub/auth/screens/login.dart';


class DetailScreen extends StatefulWidget {
  final Book book;

  DetailScreen({required this.book});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<List<Detail>> fetchProduct() async {
    // fetch review
    var url = Uri.parse(
      'https://readhub-c13-tk.pbp.cs.ui.ac.id/detail/${widget.book.pk}/get-item-json-flutter'
      );
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Detail> list_product = [];
    for (var d in data) {
        if (d != null) {
            list_product.add(Detail.fromJson(d));
        }
    }
    return list_product;
  }
  Future<List<Book>> fetchSimilar() async {
    var url = Uri.parse('https://readhub-c13-tk.pbp.cs.ui.ac.id/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Book> allBooks = [];
    for (var d in data) {
      if (d != null) {
        allBooks.add(Book.fromJson(d));
      }
    }

    // Filter and sort books based on genre similarity
    List<Book> similarBooks = [];
    for (var book in allBooks) {
      // Check if the book has at least one common genre with the target book
      List<String> commonGenres = book.fields.genres.split('|')
          .where((genre) =>
              widget.book.fields.genres.split('|').contains(genre))
          .toList();

      if (commonGenres.isNotEmpty) {
        similarBooks.add(book);
      }
    }

  // Sort similarBooks based on the number of common genres (descending order)
  similarBooks.sort((a, b) =>
      b.fields.genres.split('|').where((genre) =>
          widget.book.fields.genres.split('|').contains(genre)).length
      .compareTo(a.fields.genres.split('|').where((genre) =>
          widget.book.fields.genres.split('|').contains(genre)).length));

  return similarBooks;
}

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double screenWidth = MediaQuery.of(context).size.width;
    double availableWidth = screenWidth - (28*2 + 125 + 16);

    return Scaffold(
      backgroundColor: Warna.background,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(27, 58, 0, 60),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff161832),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

// <<< Tombol Arrow >>> //

          Container(
            margin: EdgeInsets.fromLTRB(5.96, 0, 27.71, 24),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  color: Warna.white,
                ),
                // Add space between the arrow icon and the favorite image
                Spacer(),
                Container(
                  // right: 4,
                  // top: 4,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () async {
                        if (request.loggedIn) {
                          // Jika sudah login, navigasi ke FavoritForm
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoritForm(book: widget.book),
                            ),
                          );
                        } else {
                          // Jika belum login, navigasi ke halaman login
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          ).then((value) {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoritForm(book: widget.book),
                            ),
                          );
                          });
                        }
                      },
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: Image.asset(
                          'assets/icons/Favorite.png',
                          width: 36,
                          height: 36,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


// <<< Details >>> //

              Container(
                margin: EdgeInsets.fromLTRB(1, 0, 28, 24),
                width: double.infinity,
                height: 180,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
                      width: 125,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Warna.backgrounddark,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 128,
                          height: 190,
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                            image: NetworkImage(widget.book.fields.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      width: availableWidth,
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                            constraints: BoxConstraints(
                              maxWidth: 500,
                            ),
                            child:  Text(
                              "${widget.book.fields.bookTitle}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                           Text(
                               "by ${widget.book.fields.bookAuthors.length  > 25 ? widget.book.fields.bookAuthors.substring(0,25).replaceAll("|", ", ") + '...' : widget.book.fields.bookAuthors.replaceAll("|", ", ")}",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.4285714286,
                              color: Color(0xffb6b6b6),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 112, 14),
                                  padding: EdgeInsets.fromLTRB(11.33, 8, 10, 8),
                                  width:90,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Color(0x19ff961b),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 7.33, 0),
                                        width: 14,
                                        height: 14,
                                        child: Image.asset(
                                          'assets/icons/Star.png',
                                          width: 13.33,
                                          height: 12.67,
                                        ),
                                      ),
                                      Text(
                                        "${widget.book.fields.bookRating}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3333333333,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  width: 200,
                                  height: 24,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 8), 
                                        width: 75, 
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xff3fbcfc),
                                          borderRadius: BorderRadius.circular(999),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${widget.book.fields.genres.split('|')[0]}",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              height: 1.6,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 75, 
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xff3fbcfc),
                                          borderRadius: BorderRadius.circular(999),
                                        ),
                                        child: Center(
                                          child: Text(
                                            widget.book.fields.genres.split('|')[1],
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              height: 1.6,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

// <<< Borrow button >>> //

              Container(
                margin: EdgeInsets.fromLTRB(1, 0, 28, 29),
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                        if (request.loggedIn) {
                          // Jika sudah login, navigasi ke FavoritForm
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BorrowScreen(book: widget.book),
                            ),
                          );
                        } else {
                          // Jika belum login, navigasi ke halaman login
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          ).then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BorrowScreen(book: widget.book),
                              ),
                            );
                          });
                        }
                      },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(96.68, 12, 94.43, 12),
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xff2a4cf1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 9.39, 0),
                          width: 40,
                          height: 15,
                          child: Image.asset(
                            'assets/icons/Bag.png', // Ganti dengan path gambar Anda
                            width: 18,
                            height: 18,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          child: const Center(
                            child: Text(
                              'Borrow This Book',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                height: 1.3333333333,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

// <<< Descriptions >>> //

              Container(
                  margin:  EdgeInsets.fromLTRB(0, 0, 0, 8),
                  width: double.infinity,
                  child:  
                const Text(
                  'Description Book',
                  style:  TextStyle (
                    fontFamily: 'Poppins',
                    fontSize:  20,
                    fontWeight:  FontWeight.w700,
                    height:  1.4,
                    color:  Color(0xffffffff),
                  ),
                ),
                ),
              Container(
                margin: EdgeInsets.fromLTRB(1, 0, 28, 32),
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child:  Text(
                  "${widget.book.fields.bookDesc}",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.4285714286,
                    color: Color(0xffffffff),
                  ),
                ),
              ),

// <<< Review >>> //

             Container(
              margin:  EdgeInsets.fromLTRB(0, 0, 15, 14.5),
              width:  double.infinity,
              height:  28,
              child:  
                Row(
                  crossAxisAlignment:  CrossAxisAlignment.center,
                  children:  [
                    Container(
                      margin:  EdgeInsets.fromLTRB(0, 0, 103, 0),
                      child:  
                    Text(
                      'Review Book',
                      style:  TextStyle (
                        fontFamily: 'Poppins',
                        fontSize:  20,
                        fontWeight:  FontWeight.w700,
                        height:  1.4,
                        color:  Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                        margin:  EdgeInsets.fromLTRB(0, 3.5, 0, 3.5),
                        child:  
                        TextButton(

// <<< Tombol add review >>> //

                          onPressed:  () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewForm(book: widget.book),
                              ),
                            );
                          },
                          style:  TextButton.styleFrom (
                            padding:  EdgeInsets.zero,
                          ),
                          child:  
                        Container(
                          padding:  EdgeInsets.fromLTRB(15, 2.5, 15, 0),
                          width:  101,
                          height:  double.infinity,
                          decoration:  BoxDecoration (
                            color:  Color(0xff2a4cf1),
                            borderRadius:  BorderRadius.circular(20),
                          ),
                          child:  
                            Container(
                              width:  double.infinity,
                              height:  25,
                              child:  
                            Text(
                              'Add Review',
                              textAlign:  TextAlign.center,
                              style:  TextStyle (
                                fontFamily: 'Poppins',
                                fontSize:  12,
                                fontWeight:  FontWeight.w600,
                                height:  1.3333333333,
                                color:  Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

// <<< Show Review >>> //
      
            FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                return Column(
                  children: [
                    Text(
                      "No review yet",
                      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 12),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                // Display the reviews using the snapshot.data
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var review in snapshot.data!)
                        if (review.book == widget.book.fields.bookTitle.toString())
                          ReviewCard(review: review),
                    ],
                  ),
                );
              }
            },
          ),


// <<< Similar Book >>> //
Container(
  margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
  width: double.infinity,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: const Text(
          'Similar Book',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.4,
            color: Color(0xffffffff),
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: 278,
        child: FutureBuilder<List<Book>>(
          future: fetchSimilar(),
          builder: (context, AsyncSnapshot<List<Book>> snapshot2) {
            if (snapshot2.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot2.hasError) {
              return Text('Error: ${snapshot2.error}');
            } else if (!snapshot2.hasData) {
              return Text('No similar books found');
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot2.data!.length,
                itemBuilder: (context, index) {
                  Book book = index < snapshot2.data!.length ? snapshot2.data![index] : Book(model: widget.book.model, pk: widget.book.pk,fields: widget.book.fields);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(book: book),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      width: 152.0,
                      decoration: BoxDecoration(
                        color: Warna.backgroundlight,
                        borderRadius: BorderRadius.circular(18.3132534027),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x05a3a3a3),
                            offset: Offset(3.6626505852, 3.6626505852),
                            blurRadius: 9.1566267014,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Warna.backgroundlight,
                              borderRadius: BorderRadius.circular(9.99081707),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: 137.91,
                                      height: 185,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: CachedNetworkImage(
                                          imageUrl: "${book.fields.imageUrl}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 4,
                                  top: 4,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () async {
                                        if (request.loggedIn) {
                                          // Jika sudah login, navigasi ke FavoritForm
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FavoritForm(book: book),
                                            ),
                                          );
                                        } else {
                                          // Jika belum login, navigasi ke halaman login
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LoginPage(),
                                            ),
                                          ).then((value) {
                                            Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FavoritForm(book: book),
                                            ),
                                          );
                                          });
                                        }
                                      },
                                      child: SizedBox(
                                        width: 32,
                                        height: 32,
                                        child: Image.asset(
                                          'assets/icons/Favorite.png',
                                          width: 36,
                                          height: 36,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            color: Warna.backgroundlight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                  constraints: const BoxConstraints(
                                    maxWidth: 135,
                                  ),
                                  child: Text(
                                    (book.fields.bookTitle.length) > 18
                                    ? (book.fields.bookTitle.substring(0, 18)) + '...'
                                    : book.fields.bookTitle,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      height: 1.3333333333,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'by ${
                                      (book.fields.bookAuthors.length) > 18
                                          ? (book.fields.bookAuthors.substring(0, 18).replaceAll("|", ", ")) + '...'
                                          : book.fields.bookAuthors.replaceAll("|", ", ")
                                    }',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      height: 1.6,
                                      color: Color(0xffb6b6b6),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              );
            }
          }
        )
            )
              ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}