import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:readhub/screens/flow/detail_book.dart';
import 'package:readhub/models/book.dart';
import 'package:readhub/styles/colors.dart';

class ReviewForm extends StatefulWidget {
  final Book book;

  ReviewForm({required this.book});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  String _review = "";
  String _username = "";
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
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Review',
          ),
        ),
        backgroundColor: Warna.background,
        foregroundColor: Warna.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 812,
            child: Stack(
              children: [
                Positioned(
                  left: 115,
                  top: 63,
                  child: Align(
                    child: SizedBox(
                      width: 145,
                      height: 32,
                      child: Text(
                        widget.book.fields.bookTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color:  Warna.background,
                        ),
                      ),
                    ),
                  ),
                ),
                
                Positioned(
                  left: 0,
                  top: 137,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(11, 74, 13, 82.5),
                    width: 376,
                    height: 675,
                    decoration: BoxDecoration(
                      color: Color(0xff161832),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Add your Review",
                              labelText: "Review",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Name",
                              labelText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _username = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Name cannot be empty!";
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
                                backgroundColor:
                                    MaterialStateProperty.all(Warna.background),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final response = await request.postJson(
                                    "http://127.0.0.1:8000/category/detail/${widget.book.pk}/create_review_flutter",
                                    jsonEncode(<String, String>{
                                      'book': _book,
                                      'review': _review,
                                      'user': _username,
                                    }),
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
                              child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
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
