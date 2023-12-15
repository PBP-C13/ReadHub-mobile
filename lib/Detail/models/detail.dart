// To parse this JSON data, do
//
//     final detail = detailFromJson(jsonString);

import 'dart:convert';

List<Detail> detailFromJson(String str) => List<Detail>.from(json.decode(str).map((x) => Detail.fromJson(x)));

String detailToJson(List<Detail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Detail {
    String user;
    String review;
    String book;

    Detail({
        required this.user,
        required this.review,
        required this.book,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        user: json["user"],
        review: json["review"],
        book: json["book"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "review": review,
        "book": book,
    };
}
