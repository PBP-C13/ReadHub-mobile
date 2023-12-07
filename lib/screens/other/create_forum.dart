import 'package:flutter/material.dart';
import 'package:readhub/models/user.dart';
import 'package:readhub/screens/navigation/community.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:readhub/styles/colors.dart';
import 'package:readhub/models/book.dart';

class CreateForum extends StatefulWidget {
  const CreateForum({super.key});

  @override
  State<CreateForum> createState() => _CreateForumState();
}


class _CreateForumState extends State<CreateForum> {
  final _formKey = GlobalKey<FormState>();
  String _forumText = "";
  String? _selectedBook;
  List<DropdownMenuItem<String>> _dropdownMenuItems = [];


  @override
  void initState() {
    //  _loadBooks();
    super.initState();
    _loadBooks();
  }

  // Fungsi untuk memuat daftar buku
  Future<void> _loadBooks() async {
    // TODO: Ganti dengan URL yang sesuai untuk mengambil daftar buku
    var url = 'https://readhub-c13-tk.pbp.cs.ui.ac.id/json/';
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      List<dynamic> books = json.decode(response.body);
        List<Book> result = [];
          for (var d in books) {
            if (d != null) {
              result.add(Book.fromJson(d));
            }
          }
      setState(() {
        _dropdownMenuItems = result.map((Book book) {
          return DropdownMenuItem(
            value: book.pk.toString(),
            child: Text(
              book.fields.bookTitle,
              overflow: TextOverflow.ellipsis, 
              style: TextStyle(color: Warna.white), 
            ),
          );
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: Warna.background,
      appBar: AppBar(
        title: const Center(),
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input untuk forum
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Forum",
                      labelText: "Forum",
                      hintStyle: TextStyle(color: Warna.abu),
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _forumText = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Forum tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                // Dropdown untuk buku
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  
                  child: Container(
                    width: MediaQuery.of(context).size.width - 16,
                    child: DropdownButtonFormField<String>(
                      value: _selectedBook,
                      items: _dropdownMenuItems,
                      decoration: InputDecoration(
                        labelText: "Buku",
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white), 
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        filled: true, // Menambahkan ini
                        fillColor: Warna.background, // Menambahkan ini
                      ),
                      dropdownColor: Warna.background, 
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBook = newValue;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Pilih buku!";
                        }
                        return null;
                      },
                       icon: Container(), // This hides the dropdown button
                        isExpanded: true, // This ensures the dropdown fills the width of its parent
                        itemHeight: 60, // Adjust the height of each dropdown item
                        style: TextStyle(color: Warna.white), // Style of the dropdown items
                      ),
                    ),
                  ),
                // Tombol simpan
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var data = {
                            'user': userlogin,
                            'Forum': _forumText,
                            'book': _selectedBook,
                          };
                          final response = await request.postJson(
                            "https://readhub-c13-tk.pbp.cs.ui.ac.id/community/create-flutter/",
                            jsonEncode(data),
                        );
                          if (response['status'] == 'success') {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const CommunityScreen()));
                          } else {
                            // Tampilkan pesan error
                            // TODO: Implementasi pesan error
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
      ),
    );
  }
}
