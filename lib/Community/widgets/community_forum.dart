import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:readhub/Community/models/forum.dart';
import 'package:readhub/Community/screens/community.dart';
import 'package:readhub/Detail/screens/detail_book.dart';
import 'package:readhub/Home/models/user.dart';
import 'package:readhub/together/models/book.dart';
import 'package:readhub/together/style/colors.dart';
import 'package:http/http.dart' as http;

class CommunityForumWidget extends StatefulWidget {
  final Forum forum;

  CommunityForumWidget({Key? key, required this.forum,}) : super(key: key);

  @override
  State<CommunityForumWidget> createState() => _CommunityForumWidgetState();
}

class _CommunityForumWidgetState extends State<CommunityForumWidget> {
  List<Book> myBooks = [];
  late Book forumbook;

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 600), 
    );
  }

  Future<void> _deleteforum(BuildContext context, CookieRequest request, Forum forum) async {
    await request.postJson(
      'https://readhub-c13-tk.pbp.cs.ui.ac.id/community/delete_item/${forum.forumId}/',
      jsonEncode({
        "forum_id": forum.forumId,
      }),
    );
    Navigator.of(context).push(_createRoute(const CommunityScreen()));
  }


 Map<int, Book>? _booksMap;

@override
void initState() {
  super.initState();
  fetchbuku().then((map) {
    if (mounted) {
      setState(() {
        _booksMap = map;
      });
    }
  });
}


Future<Map<int, Book>> fetchbuku() async {
  var url = Uri.parse('https://readhub-c13-tk.pbp.cs.ui.ac.id/json/');
  var response = await http.get(url, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    Map<int, Book> booksMap = {};
    for (var d in data) {
      if (d != null) {
        Book book = Book.fromJson(d);
        booksMap[book.pk] = book;  // Assuming 'id' is the unique identifier in your Book model
      }
    }
    return booksMap;
  } else {
    throw Exception('Failed to fetch books. Status code: ${response.statusCode}');
  }
}


  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth - 28 * 2;
    final request = context.watch<CookieRequest>();
    
    return InkWell(
      // onTap: () {
      //   Navigator.of(context).push(_createRoute(const CommunityScreen()));
      // },
      child: Container(
        width: contentWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
              width: contentWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    width: screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                  width: 56,
                                  height: 56,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(26),
                                    child: Image.asset(
                                      'assets/images/Profile.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.forum.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    height: 1.6,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            widget.forum.name == userlogin // Cek apakah nama forum sama dengan user yang login
                              ? PopupMenuButton<String>(
                                  icon: Icon(Icons.more_vert, color: Colors.white),
                                  onSelected: (value) {
                                    if (value == 'delete') {
                                     _deleteforum(context, request, widget.forum);
                                    }
                                  },
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete, color: Colors.red),
                                            SizedBox(width: 8),
                                            Text('Delete'),
                                          ],
                                        ),
                                      ),
                                    ];
                                  },
                                )
                              : Container(), // Jika tidak sama, tidak menampilkan apa-apa
                        ],
                      ),

                        SizedBox(height: 16),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: contentWidth,
                          ),
                          child: Text(
                            widget.forum.forumText,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  Container(
                    width: contentWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: Text(
                            'Book',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Color(0xff23264f),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                decoration: BoxDecoration(
                                  color: Warna.backgroundlight,
                                  borderRadius: BorderRadius.circular(6.0704197884),
                                ),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 84,
                                    height: 128,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      image: DecorationImage(
                                        image: NetworkImage(widget.forum.bookImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                width: screenWidth - screenWidth / 2.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      width: screenWidth - 40,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                                            child: Text(
                                              widget.forum.bookTitle,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                height: 1.5,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'by: ${widget.forum.bookAuthor}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5,
                                              color: Color(0xff818181),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (_booksMap?.containsKey(widget.forum.bookId) ?? false) {
                                          Book? book = _booksMap?[widget.forum.bookId];

                                          if (book != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DetailScreen(book: book),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(17.5, 8, 17.5, 8),
                                        width: 120,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: Warna.blue,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'See detail',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              height: 1.5,
                                              color: Colors.white,
                                            ),
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
            Container(
              width: screenHeight,
              height: 1.5,
              color: Warna.backgroundlight,
            ),
            SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
