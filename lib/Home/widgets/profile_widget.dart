import 'package:flutter/material.dart';
import 'package:readhub/Home/models/user.dart';
import 'package:readhub/Home/screens/privacy_policy.dart';
import 'package:readhub/auth/screens/onboarding.dart';
import 'package:readhub/Explore/screens/favoritPage.dart';
import 'package:readhub/Home/screens/edit_user.dart';
import 'package:readhub/together/style/colors.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void handleLogout(BuildContext context) async {
  final request = Provider.of<CookieRequest>(context, listen: false);
  final response = await request.logout("https://readhub-c13-tk.pbp.cs.ui.ac.id/auth/logout/");
  String message = response["message"];
  if (response['status']) {
    String uname = response["username"];
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$message Sampai jumpa, $uname."),
    ));
    isUserLoggedIn= false;
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      // ignore: prefer_const_constructors
      MaterialPageRoute(builder: (context) => Onboarding()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      // ignore: unnecessary_string_interpolations
      content: Text("$message"),
    ));
  }
}


class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}
class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Warna.blue, // Set the overall background to blue
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), 
            topRight: Radius.circular(40), 
          ),
          child: Container(
            width: double.infinity,
            color: Warna.background,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProfileOption("Edit Display Name", "assets/icons/Edit Profile.png", () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>EditProfile(usernameController:  TextEditingController(text: userlogin,))));
                  }),
                  SizedBox(height: 24),
                  _buildProfileOption("Favorite Book", "assets/icons/Favorite Book.png", () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritScreen()));
                  }),
                  SizedBox(height: 24),
                  _buildProfileOption("Privacy Policy", "assets/icons/Privacy Policy.png", () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                  }),
                  SizedBox(height: 24),
                  _buildProfileOption("Logout", "assets/icons/Logout.png", () {
                    handleLogout(context);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(String title, String iconPath, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
        
      child: Container(
        width: double.infinity,
        color: Colors.transparent, // Set background color for each option if needed
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
              width: 40,
              height: 40,
              child: Image.asset(iconPath),
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Warna.white, // Change text color if needed
                ),
              ),
            ),
            // Adjusting the size of the arrow icon to make it square
            Container(
              width: 20, // Square size
              height: 20, // Square size
              child: Image.asset("assets/icons/Left Arrow.png", fit: BoxFit.cover),
            ),
          ],
        ),
      ),
      );
  }
}
