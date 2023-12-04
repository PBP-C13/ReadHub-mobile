import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:readhub/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readhub/widgets/navbar.dart';
import 'package:readhub/screens/navigation/home.dart';
import 'package:readhub/screens/navigation/explore.dart';
import 'package:readhub/screens/navigation/mybook.dart';
import 'package:readhub/screens/navigation/profile.dart';
import 'package:readhub/models/book.dart';

class DetailScreen extends StatefulWidget {
  final Book book;

  DetailScreen({required this.book});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.background,
      bottomNavigationBar: BottomNavBar(index: 0),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(27, 58, 0, 60),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff161832),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(5.96, 0, 27.71, 24),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0.64, 260.84, 0),
                      width: 17.5,
                      height: 14.06,
                      child: Image.network(
                        '[Image url]',
                        width: 17.5,
                        height: 14.06,
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      child: Image.network(
                        '[Image url]',
                        width: 36,
                        height: 36,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(1, 0, 28, 24),
                width: double.infinity,
                height: 180,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
                      width: 125,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffc52525),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 128,
                          height: 190,
                          child: Image.network(
                            '[Image url]',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      width: 180,
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                            constraints: BoxConstraints(
                              maxWidth: 180,
                            ),
                            child: Text(
                              "Book Title: ${widget.book.fields.bookTitle}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                          Text(
                               "Author: ${widget.book.fields.bookAuthors}",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.4285714286,
                              color: Color(0xffb6b6b6),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 112, 14),
                                  padding: EdgeInsets.fromLTRB(11.33, 8, 10, 8),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0x19ff961b),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 7.33, 0),
                                        width: 13.33,
                                        height: 12.67,
                                        child: Image.network(
                                          '[Image url]',
                                          width: 13.33,
                                          height: 12.67,
                                        ),
                                      ),
                                      const Text(
                                        '3.96',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3333333333,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 41, 0),
                                  width: double.infinity,
                                  height: 24,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                                        width: 57,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xff3fbcfc),
                                          borderRadius: BorderRadius.circular(999),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Fantasy',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              height: 1.6,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 78,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xfff2f2f2),
                                          borderRadius: BorderRadius.circular(999),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Fiction',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              height: 1.6,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(1, 0, 28, 29),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(96.68, 12, 94.43, 12),
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xff2a4cf1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 9.39, 0),
                          width: 13.5,
                          height: 15,
                          child: Image.network(
                            '[Image url]',
                            width: 13.5,
                            height: 15,
                          ),
                        ),
                        Container(
                          width: 105,
                          height: double.infinity,
                          child: const Center(
                            child: Text(
                              'Borrow This Book',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                height: 1.3333333333,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  // descriptionbookei7 (187:7995)
                  margin:  EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child:  
                const Text(
                  'Description Book',
                  style:  TextStyle (
                    fontFamily: 'Poppins',
                    fontSize:  20,
                    fontWeight:  FontWeight.w700,
                    height:  1.4,
                    color:  Color(0xffffffff),
                  ),
                ),
                ),
              Container(
                margin: EdgeInsets.fromLTRB(1, 0, 0, 32),
                constraints: const BoxConstraints(
                  maxWidth: 320,
                ),
                child: const Text(
                  'Lyra is rushing to the cold, far North, where witch clans and armored bears rule. North, where the Gobblers take the children they steal--including her friend Roger. North, where her fearsome uncle Asriel is trying to build a bridge to a parallel world.Can one small girl make a difference in such great and terrible endeavors? This is Lyra: a savage, a schemer, a liar, and as fierce and true a champion as Roger or Asriel could want--but what Lyra doesn\'t know is that to help one of them will be to betray the other.A masterwork of storytelling and suspense, Philip Pullman\'s award-winning The Golden Compass is the first in the His Dark Materials series, which continues with The Subtle Knife and The Amber Spyglass."',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.4285714286,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Container(
  // reviewbookAiP (187:7996)
                margin:  EdgeInsets.fromLTRB(0, 0, 0, 12),
                child:  
              Text(
                'Review Book',
                style:  TextStyle (
                  fontFamily: 'Poppins',
                  fontSize:  20,
                  fontWeight:  FontWeight.w700,
                  height:  1.4,
                  color:  Color(0xffffffff),
                ),
              ),
              ),
              Container(
                // autogroupnp15tuH (AtrmP2KKR8BuB64TzpNP15)
                margin:  EdgeInsets.fromLTRB(1, 0, 0, 32),
                width:  double.infinity,
                height:  180,
                child:  
              Row(
                crossAxisAlignment:  CrossAxisAlignment.center,
                children:  [
              Container(
                // frame1171275474RuD (187:7998)
                margin:  EdgeInsets.fromLTRB(0, 0, 16, 0),
                padding:  EdgeInsets.fromLTRB(12, 20, 16, 23),
                height:  double.infinity,
                decoration:  BoxDecoration (
                  color:  Color(0xff23264f),
                  borderRadius:  BorderRadius.circular(16.683599472),
                ),
                child:  
              Column(
                crossAxisAlignment:  CrossAxisAlignment.start,
                children:  [
              Container(
                // loremipsumdolorsitametconsecte (187:7999)
                margin:  EdgeInsets.fromLTRB(0, 0, 0, 16),
                constraints:  const BoxConstraints (
                  maxWidth:  172,
                ),
                child:  
              RichText(
                text:  
              const TextSpan(
                style:  TextStyle (
                  fontFamily: 'Poppins',
                  fontSize:  14,
                  fontWeight:  FontWeight.w500,
                  height:  1.4285714286,
                  color:  Color(0xffffffff),
                ),
                children:  [
              TextSpan(
                text:  'Lorem ipsum dolor sit amet consectetur. Sapien nunc dolor dolor vitae velit risus. Sapien nunc dolor... ',
                style:  TextStyle (
                  fontFamily: 'Poppins',
                  fontSize:  14,
                  fontWeight:  FontWeight.w500,
                  height:  1.4285714286,
                  color:  Color(0xffffffff),
                ),
              ),
              TextSpan(
                text:  'More',
                style:  TextStyle (
                  fontFamily: 'Poppins',
                  fontSize:  14,
                  fontWeight:  FontWeight.w500,
                  height:  1.4285714286,
                  color:  Color(0xff3fbcfc),
                ),
              ),
                ],
              ),
              ),
              ),
              const Text(
                // aryawijaya9Vm (187:8000)
                '-Arya Wijaya',
                style:  TextStyle (
                  fontFamily: 'Poppins',
                  fontSize:  13.3468799591,
                  fontWeight:  FontWeight.w500,
                  height:  1.5000000715,
                  color:  Color(0xffffffff),
                ),
              ),
                ],
              ),
              ),
              Container(
                // frame1171275488gEo (187:8001)
                padding:  EdgeInsets.fromLTRB(12, 20, 16, 23),
                width:  200,
                height:  double.infinity,
                decoration:  BoxDecoration (
                  color:  Color(0xff23264f),
                  borderRadius:  BorderRadius.circular(16.683599472),
                ),
                child:  
              Column(
                crossAxisAlignment:  CrossAxisAlignment.start,
                children:  [
              Container(
                // loremipsumdolorsitametconsecte (187:8002)
                margin:  EdgeInsets.fromLTRB(0, 0, 0, 16),
                constraints:  const BoxConstraints (
                  maxWidth:  172,
                ),
                child:  
              RichText(
                text:  
              const TextSpan(
                style:  TextStyle (
                  fontFamily: 'Poppins',
                  fontSize:  14,
                  fontWeight:  FontWeight.w500,
                  height:  1.4285714286,
                  color:  Color(0xffffffff),
                ),
                children:  [
              TextSpan(
                text:  'Lorem ipsum dolor sit amet consectetur. Sapien nunc dolor dolor vitae velit risus. Sapien nunc dolor... ',
                style:  TextStyle (
                  fontFamily: 'Poppins',
                  fontSize:  14,
                  fontWeight:  FontWeight.w500,
                  height:  1.4285714286,
                  color:  Color(0xffffffff),
                ),
              ),
              TextSpan(
                text:  'More',
                style:  TextStyle (
                  fontFamily: 'Poppins',
                  fontSize:  14,
                  fontWeight:  FontWeight.w500,
                  height:  1.4285714286,
                  color:  Color(0xff3fbcfc),
                ),
              ),
                ],
              ),
              ),
              ),
              const Text(
                // aryawijayazoD (187:8003)
                '-Arya Wijaya',
                style:  TextStyle (
                  fontFamily: 'Poppins',
                  fontSize:  13.3468799591,
                  fontWeight:  FontWeight.w500,
                  height:  1.5000000715,
                  color:  Color(0xffffffff),
                ),
              ),
                ],
              ),
              ),
              
      ]
      ),
    ),
             Container(
                  // frame1171275480KtH (187:8004)
                    margin:  EdgeInsets.fromLTRB(2, 0, 0, 0),
                    width:  480,
                    child:  
                  Column(
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children:  [
                  Container(
                    // bestseller4L5 (187:8005)
                    margin:  EdgeInsets.fromLTRB(0, 0, 0, 12),
                    child:  
                  const Text(
                    'Best Seller',
                    style:  TextStyle (
                      fontFamily: 'Poppins',
                      fontWeight:  FontWeight.w700,
                      height:  1.4,
                      color:  Color(0xffffffff),
            ),
          ),
          ),
                Container(
                    // frame1171275479Bfb (187:8006)
                    width:  double.infinity,
                    height:  248,
                    child:  
                  Row(
                    crossAxisAlignment:  CrossAxisAlignment.center,
                    children:  [
                  Container(
                    // cardvdB (187:8007)
                    padding:  EdgeInsets.fromLTRB(8, 8, 8, 16),
                    width:  152,
                    height:  double.infinity,
                    decoration:  BoxDecoration (
                      color:  Color(0xff292c4f),
                      borderRadius:  BorderRadius.circular(18.3132534027),
                      boxShadow:  const [
                        BoxShadow(
                          color:  Color(0x05a3a3a3),
                          offset:  Offset(3.6626505852, 3.6626505852),
                          blurRadius:  9.1566267014,
                        ),
                      ],
                    ),
                    child:  
                      Container(
                            // frame11712754382RK (187:8008)
                            width: double.infinity,
                            height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // frame1171275392nQV (187:8009)
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                  width: double.infinity,
                                  height: 164,
                                  decoration: BoxDecoration(
                                    color: Color(0xff22264f),
                                    borderRadius: BorderRadius.circular(9.99081707),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        // image62Jdj (187:8010)
                                        left: -2.0607910156,
                                        top: 0,
                                        child: Align(
                                          child: SizedBox(
                                            width: 137.91,
                                            height: 204.99,
                                            child: Image.network(
                                              '[Image url]', // Replace with your actual image URL
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        // favoriteceR (187:8011)
                                        left: 100,
                                        top: 4,
                                        child: Align(
                                          child: SizedBox(
                                            width: 32,
                                            height: 32,
                                            child: Image.network(
                                              '[Image url]', // Replace with your actual image URL
                                              width: 32,
                                              height: 32,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        // favoriteJn9 (187:8012)
                                        left: 100,
                                        top: 4,
                                        child: Align(
                                          child: SizedBox(
                                            width: 32,
                                            height: 32,
                                            child: Image.network(
                                              '[Image url]', // Replace with your actual image URL
                                              width: 32,
                                              height: 32,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // frame1171275437q1P (187:8013)
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // thegoldencompassberuangputihya (187:8014)
                                        margin: EdgeInsets.fromLTRB(0 , 0 , 0 , 4 ),
                                        constraints: const BoxConstraints(
                                          maxWidth: 135 ,
                                        ),
                                        child: const Text(
                                          'The Golden Compass Beruang Putih yang ...',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12 ,
                                            fontWeight: FontWeight.w700,
                                            height: 1.3333333333  ,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        // byaryawijayaHty (187:8015)
                                        'by Arya Wijaya',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 10 ,
                                          fontWeight: FontWeight.w500,
                                          height: 1.6  ,
                                          color: Color(0xffb6b6b6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 12 ,
                                ),
                              ],
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}