import 'package:readhub/Home/models/user.dart';
import 'package:readhub/auth/screens/register.dart';
import 'package:readhub/Home/screens/home.dart';
import 'package:readhub/together/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 28.0,
                  left: 8.0,
                  right: 8.0,
                  bottom: 8.0), // Adjusted padding here
              child: Text(
                'Login ReadHub',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                  color: Warna.white,
                ),
              ),
            ),
          ),
          backgroundColor: Warna.blue),
      backgroundColor: Warna.blue,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Auth.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: screenHeight / 2,
                  decoration: const BoxDecoration(
                    color: Warna.background,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                  ),
                ),
              ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
          height: screenHeight / 2,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
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
                        child: Container(
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
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
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
                        child: Container(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        // action for forgot password
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              color: Warna.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Warna.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18.0),
                ElevatedButton(
                  onPressed: () async {
                    String username = _usernameController.text;
                    String password = _passwordController.text;

                    // Cek kredensial
                    final response = await request.login(
                        "https://readhub-c13-tk.pbp.cs.ui.ac.id/auth/login/", {
                      'username': username,
                      'password': password,
                    });
                    userlogin=response['username'];

                    if (request.loggedIn) {
                      String message = response['message'];
                      String uname = response['username'];
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Homescreen()),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text("$message Welcome, $uname.")));
                    } else {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Login Failed'),
                          content: Text(response['message']),
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
                    'Login',
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
                const SizedBox(height: 20.0),
                Text(
                  'Belum Punya Akun',
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
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    'Register',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: Warna.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Warna.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      // ),
    ],
      ),
    );
  }
}
