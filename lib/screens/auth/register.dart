import 'package:readhub/screens/auth/login.dart';
import 'package:readhub/screens/menu.dart';
import 'package:readhub/main.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:readhub/screens/auth/register.dart';
import 'package:readhub/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';



void main() {
  runApp(const RegisterApp());
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
       appBar: AppBar(
         title: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 28.0, left: 8.0, right: 8.0, bottom: 8.0), // Adjusted padding here
            child: Text(
              'Register ReadHub',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                height: 1.5,
                color: Warna.white,
              ),
            ),
          ),
          ),
          backgroundColor:Warna.blue
      ),
      backgroundColor: Warna.blue,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Auth.png',
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight / 2,
              decoration: BoxDecoration(
                color: Warna.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight / 3.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _usernameController,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: Warna.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10), 
                          child:Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 10), 
                          decoration: BoxDecoration(
                            color: Warna.lightcyan, 
                            shape: BoxShape.circle, 
                          ),
                          child: Icon(Icons.person, color: Warna.cyan),
                          ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Warna.cyan),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Warna.line),
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                 child: TextField(
                  controller: _passwordController,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: Warna.white,
                      ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10), 
                          child:Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 10), 
                          decoration: BoxDecoration(
                            color: Warna.lightcyan, 
                            shape: BoxShape.circle, 
                          ),
                          child: Icon(Icons.lock, color: Warna.cyan),
                          ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // change the icon based on the password visibility
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          // password visibility state
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Warna.cyan),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Warna.line),
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    obscureText: !_passwordVisible, // Toggle
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _passwordConfirmationController,
                     style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: Warna.white,
                      ),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                     prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10), 
                          child:Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 10), 
                          decoration: BoxDecoration(
                            color: Warna.lightcyan, 
                            shape: BoxShape.circle, 
                          ),
                          child: Icon(Icons.lock, color: Warna.cyan),
                          ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Warna.cyan),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Warna.line),
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    obscureText: !_passwordVisible, // Toggle
                  ),
                ),
                const SizedBox(height: 18.0),
                ElevatedButton(
                  onPressed: () async {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    String passwordConfirmation =
                        _passwordConfirmationController.text;

                    // Perform input validation
                    if (username.isEmpty ||
                        password.isEmpty ||
                        passwordConfirmation.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Registration Failed'),
                          content: const Text('Please fill in all fields.'),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                      return;
                    }

                    if (password != passwordConfirmation) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Registration Failed'),
                          content: const Text('Passwords do not match.'),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                      return;
                    }
                    // Registration logic, send registration request to your server API
                    final response = await http.post(
                      Uri.parse('https://readhub-c13-tk.pbp.cs.ui.ac.id/auth/register/'),
                      body: {
                        'username': username,
                        'password1': password,
                        'password2': passwordConfirmation,
                      },
                    );

                    if (response.statusCode == 201) {
                      // Registration successful
                      String message = 'Registration successful. Please Log in';
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          content: Text(message),
                        ));
                    } else {
                      // Registration failed
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Registration Failed'),
                          content: Text(
                              'Registration failed. Please try again later.'),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Register',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                      color: Warna.white,
                      ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(385, 64),
                    backgroundColor: Warna.blue,
                  ),
                ),
                 const SizedBox(height: 16.0),
                    Text(
                      'Sudah Punya Akun',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: Warna.white,
                        ),
                        ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage()),
                          );
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            color: Warna.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Warna.white
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}