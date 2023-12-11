import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:readhub/screens/flow/detail_book.dart';
import 'package:readhub/models/detail.dart';
import 'package:readhub/models/book.dart';
import 'package:readhub/screens/navigation/explore.dart';
import 'package:readhub/styles/colors.dart';

class FavoritForm extends StatefulWidget {
  final Book book;

  FavoritForm({required this.book});

  @override
  State<FavoritForm> createState() => _FavoritFormState();
}

class _FavoritFormState extends State<FavoritForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isFavorit = true; // Default to Yes
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
            'Add Favorit',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Warna.background,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Do you recommend this book?"),
                    Radio(
                      value: true,
                      groupValue: _isFavorit,
                      onChanged: (bool? value) {
                        setState(() {
                          _isFavorit = value!;
                        });
                      },
                    ),
                    Text("Yes"),
                    Radio(
                      value: false,
                      groupValue: _isFavorit,
                      onChanged: (bool? value) {
                        setState(() {
                          _isFavorit = value!;
                        });
                      },
                    ),
                    Text("No"),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                          "http://localhost:8000/category/add-favorit-flutter/${widget.book.pk}/",
                          jsonEncode(<String, dynamic>{
                            'book': _book,
                            'isFavorit': _isFavorit,
                          }),
                          
                        );
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Item Addition Confirmed!"),
                          ));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ExploreScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Terdapat kesalahan, silakan coba lagi."),
                          ));
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
    );
  }
}
