// To parse this JSON data, do
//
//     final favorit = favoritFromJson(jsonString);

import 'dart:convert';

List<Favorit> favoritFromJson(String str) => List<Favorit>.from(json.decode(str).map((x) => Favorit.fromJson(x)));

String favoritToJson(List<Favorit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favorit {
    String model;
    int pk;
    Fields fields;

    Favorit({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Favorit.fromJson(Map<String, dynamic> json) => Favorit(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String nameCategory;
    int books;
    int user;
    bool isFavorite;

    Fields({
        required this.nameCategory,
        required this.books,
        required this.user,
        required this.isFavorite,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        nameCategory: json["name_category"],
        books: json["books"],
        user: json["user"],
        isFavorite: json["is_favorite"],
    );

    Map<String, dynamic> toJson() => {
        "name_category": nameCategory,
        "books": books,
        "user": user,
        "is_favorite": isFavorite,
    };
}
