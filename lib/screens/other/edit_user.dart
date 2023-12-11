import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/models/user.dart';
import 'package:readhub/screens/navigation/profile.dart';
import 'package:readhub/styles/colors.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  final TextEditingController usernameController;
  EditProfile({
    Key? key,
    required this.usernameController,
  }) : super(key: key);

  Future<void> _editDisplayname(BuildContext context, request) async {
    // Assuming you have already checked that usernameController.text is not empty
    final newUsername = usernameController.text;

    // Update the login user locally without making a network request
    // You can store this information in a global state management solution
    // or a local storage, depending on your app architecture
    // For simplicity, let's assume you have a global variable for login user
    userlogin = newUsername;

    // Show success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Success'),
          content: Text('You have successfully edited your username.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: Warna.background,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.5,
            color: Warna.white,
          ),
        ),
        backgroundColor: Warna.background,
        foregroundColor: Warna.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Display Name',
                hintText: 'New Display Name',
                labelStyle:
                    TextStyle(color: Colors.white), // Set label text color
                hintStyle:
                    TextStyle(color: Colors.white), // Set hint text color
              ),
            ),
            SizedBox(height: 8),
            SizedBox(height: 16),
            InkWell(
              onTap: () => _editDisplayname(context, request),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xff0056ff)),
                height: 50,
                width: 280,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Color(0xff0056ff)),
                        height: 50,
                        child: const Align(
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
    );
  }
}
