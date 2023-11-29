import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readhub/styles/colors.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.blue,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Onboarding Screen.png',
              fit: BoxFit.fill, 
            ),
          ),
          
        ],
      ),
    );
  }
}
