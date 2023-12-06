import 'package:flutter/material.dart';
import 'package:readhub/screens/navigation/community.dart';
import 'dart:convert'; 
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:readhub/styles/colors.dart';

class CreateForum extends StatefulWidget {
    const CreateForum({super.key});

    @override
    State<CreateForum> createState() => _CreateForumState();
}

class _CreateForumState extends State<CreateForum> {
  final _formKey = GlobalKey<FormState>();
  String _forum = "";
  String _description = "";
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
      padding: EdgeInsets.only(left: 20), // Add padding of 28 pixels to the left
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop(); // This line will navigate back
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
                          decoration: InputDecoration(
                          hintText: "Forum",
                          labelText: "Forum",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                          ),
                          ),
                          onChanged: (String? value) {
                          setState(() {
                              _forum = value!;
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
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          decoration: InputDecoration(
                          hintText: "Buku",
                          labelText: "Buku",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                          ),
                          ),
                          onChanged: (String? value) {
                          setState(() {
                              // TODO: Tambahkan variabel yang sesuai
                              _description = value!;
                          });
                          },
                          validator: (String? value) {
                          if (value == null || value.isEmpty) {
                              return "Buku tidak boleh kosong!";
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
                                          MaterialStateProperty.all(Colors.indigo),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
      
                                        final response = await request.postJson(
                                        "http://127.0.0.1:8000/community/create-flutter/",
                                        jsonEncode(<String, String>{
                                            'name': _forum,
                                            'description': _description,
                                        }));
                                        if (response['status'] == 'success') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                            content: Text("Produk baru berhasil disimpan!"),
                                            ));
                                            // ignore: use_build_context_synchronously
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text('Produk berhasil tersimpan'),
                                                  content: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Nama: $_forum'),
                                                        Text('Deskripsi: $_description'),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('OK'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            // ignore: use_build_context_synchronously
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => CommunityScreen()),
                                            );
                                        } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content:
                                                    Text("Terdapat kesalahan, silakan coba lagi."),
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
                    ]
                  )
              ),
          ),
    ),
    );
  }
}