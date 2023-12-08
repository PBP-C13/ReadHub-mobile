import 'package:flutter/material.dart';
import 'package:readhub/models/detail.dart';

class ReviewCard extends StatelessWidget {
  final Detail review;

  ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160, 
      width: 190,
      child: Card(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        color: Color(0xff23264f),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.review.length > 45 ? '${review.review.substring(0, 45)}...' : review.review,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.4285714286,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              if (review.review.length > 45)
                Text(
                  'More',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.4285714286,
                    color: Color(0xff3fbcfc),
                  ),
                ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "- ${review.user}",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.3468799591,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
