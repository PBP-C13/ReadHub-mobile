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
  Future<List<Privacyp>> fetchProduct(request) async {
    var response =
        await request.get('http://127.0.0.1:8000/get-privacy-policy/');

    List<Privacyp> listProduct = [];
    for (var d in response) {
      if (d != null) {
        listProduct.add(Privacyp.fromJson(d));
      }
    }
    print(listProduct);
    return listProduct;
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
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                ListView(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28.0, vertical: 12.0),
                          child: Text(
                            snapshot.data![index].privacyPolicyText,
                            style: GoogleFonts.poppins(
                              color: Colors.white, // Set text color to white
                              fontSize: 16.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
