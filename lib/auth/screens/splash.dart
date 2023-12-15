import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readhub/auth/screens/onboarding.dart';
import 'package:readhub/together/style/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => Onboarding(),
          ),
          (route) => false);
    });

    return Scaffold(
      backgroundColor: Warna.background,
      body: Stack(
        children: [
          Center(
            child: Image.asset('assets/images/Background Splash.png'),
          ),
        ],
      ),
    );
  }
}