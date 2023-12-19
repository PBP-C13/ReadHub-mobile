import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:readhub/Detail/screens/detail_book.dart';
import 'package:readhub/Detail/models/detail.dart';
import 'package:readhub/together/models/book.dart';
import 'package:readhub/Explore/screens/explore.dart';
import 'package:readhub/together/style/colors.dart';
import 'package:readhub/Explore/screens/favoritPage.dart';
import 'package:google_fonts/google_fonts.dart';



class FavoritForm extends StatefulWidget {
  final Book book;

  FavoritForm({required this.book});

  @override
  State<FavoritForm> createState() => _FavoritFormState();
}

class _FavoritFormState extends State<FavoritForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isFavorit = true; // Default to Yes
  late Book _book;

  @override
  void initState() {
    super.initState();
    _book = widget.book;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
       backgroundColor: Warna.background,
      appBar: AppBar(
        title: Text(
          'Add Favorit',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold, // Poppins Bold
          ),
        ),
        backgroundColor: Warna.background,
        iconTheme: IconThemeData(color: Colors.white),
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        centerTitle: true, // Center the title
        foregroundColor: Warna.white,
      ),
        body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: [
                Text(
                  "Apakah anda ingin menambahkan buku ini ke list favorit?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                      value: true,
                      groupValue: _isFavorit,
                      onChanged: (bool? value) {
                        setState(() {
                          _isFavorit = value!;
                        });
                      },
                      activeColor: Warna.cyan,
                    ),
                    Text("Yes",
                    style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    Radio(
                      value: false,
                      groupValue: _isFavorit,
                      onChanged: (bool? value) {
                        setState(() {
                          _isFavorit = value!;
                        });
                      },
                      activeColor: Warna.cyan,
                    ),
                    Text("No",
                    style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ],
                ),

              Align(
                alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Warna.blue),
                        // Setting the button height and border radius
                        minimumSize: MaterialStateProperty.all(Size(double.infinity, 56)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), 
                          ),
                        ),
                      ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                          "https://readhub-c13-tk.pbp.cs.ui.ac.id/category/add-favorit-flutter/${widget.book.pk}/",
                          jsonEncode(<dynamic, dynamic>{
                            'book': _book,
                            'isFavorit': _isFavorit,
                          }),
                          
                        );
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Berhasil menambahkan buku ke favorit"),
                          ));
                          Navigator.of(context).pop();

                        } else if(response['status'] == 'error'){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Buku ini sudah berada di list Favorit"),
                          ));
                          Navigator.of(context).pop();
                        }else if(response['status'] == 'no'){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Buku tidak ditambahkan ke list Favorit"),
                          ));
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: Center( // Center the text within the button
                      child: Text(
                        'Add Favorite', // Button text
                        style: TextStyle( // Adjust the text style
                          fontFamily: 'Poppins',
                          fontSize: 16, // Font size
                          fontWeight: FontWeight.w700, // Bold text
                          height: 1.5, // Line height
                          color: Color(0xffffffff), // Text color (white)
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
        ),
    );
  }
}
