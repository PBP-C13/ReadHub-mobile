import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:readhub/Detail/screens/detail_book.dart';
import 'package:readhub/Home/models/user.dart';
import 'package:readhub/together/models/book.dart';
import 'package:readhub/together/style/colors.dart';

class ReviewForm extends StatefulWidget {
  final Book book;

  ReviewForm({required this.book});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  String _review = "";
  late String _book;

  @override
  void initState() {
    super.initState();
    _book = widget.book.fields.bookTitle;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: Warna.background,
      appBar: AppBar(
        title: Center(
          child: Text(
            _book.length > 50 ? _book.substring(0,50) + "..." : _book,
             style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
        backgroundColor: Warna.background,
        foregroundColor: Warna.white,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Add your Review",
                      labelText: "Review",
                      hintStyle: TextStyle(color: Warna.abu),
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true, // Mengaktifkan latar belakang terisi
                      fillColor: Warna.background, // Atur warna latar belakang sesuai kebutuhan Anda 
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Warna.background),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _review = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Review cannot be empty!";
                      }
                      return null;
                    },
                  ),
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
                                  var data = {
                                      'user': userlogin,
                                      'book': _book,
                                      'review': _review,
                                  };
                                  final response = await request.postJson(
                                    "https://readhub-c13-tk.pbp.cs.ui.ac.id/detail/${widget.book.pk}/create-product-flutter/",
                                    jsonEncode(data),
                                );
                                  if (response['status'] == 'success') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Item Addition Confirmed!"),
                                      ),
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailScreen(book: widget.book),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Terdapat kesalahan, silakan coba lagi."),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Center( // Center the text within the button
                                child: Text(
                                  'Save', // Button text
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
