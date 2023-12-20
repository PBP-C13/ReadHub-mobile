import 'package:flutter/material.dart';
import 'package:readhub/Home/models/Privacyp.dart';
import 'package:readhub/together/style/colors.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  Future<Privacyp> fetchPrivacyPolicy(CookieRequest request) async {
    var data = await request.get('https://readhub-c13-tk.pbp.cs.ui.ac.id/privacy_policy/');
    return Privacyp.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: Warna.background,
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.5,
            color: Warna.white,
          ),
          
        ),
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
      body: FutureBuilder<Privacyp>(
        future: fetchPrivacyPolicy(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Split the text by new lines
            List<String> parts = snapshot.data!.privacyPolicy.split('\n\n');
            List<TextSpan> textSpans = [];

            for (var i = 0; i < parts.length; i++) {
              if (i > 0) {
                textSpans.add(TextSpan(text: '\n\n'));
              }
              // Make the first line of each part bold
              List<String> subParts = parts[i].split('\n');
              if (subParts.isNotEmpty) {
                textSpans.add(TextSpan(
                  text: subParts.first,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0,
                    height: 2, 
                  ),
                ));
                textSpans.add(TextSpan(text: '\n'));
                textSpans.add(TextSpan(
                  text: subParts.skip(1).join('\n'),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16.0,
                    height: 2, 
                  ),
                ));
              }
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
              child: RichText(
                text: TextSpan(
                  children: textSpans,
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}