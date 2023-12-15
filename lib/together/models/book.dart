// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    String model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: json["model"]!,
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
    String bookAuthors;
    String? bookDesc;
    dynamic bookEdition;
    String? bookFormat;
    String? bookIsbn;
    String? bookPages;
    double? bookRating;
    int? bookRatingCount;
    int? bookReviewCount;
    String bookTitle;
    String genres;
    String imageUrl;

    Fields({
        required this.bookAuthors,
        required this.bookDesc,
        required this.bookEdition,
        required this.bookFormat,
        required this.bookIsbn,
        required this.bookPages,
        required this.bookRating,
        required this.bookRatingCount,
        required this.bookReviewCount,
        required this.bookTitle,
        required this.genres,
        required this.imageUrl,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        bookAuthors: json["book_authors"],
        bookDesc: json["book_desc"],
        bookEdition: json["book_edition"],
        bookFormat: json["book_format"],
        bookIsbn: json["book_isbn"],
        bookPages: json["book_pages"],
        bookRating: json["book_rating"]?.toDouble(),
        bookRatingCount: json["book_rating_count"],
        bookReviewCount: json["book_review_count"],
        bookTitle: json["book_title"],
        genres: json["genres"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "book_authors": bookAuthors,
        "book_desc": bookDesc,
        "book_edition": bookEdition,
        "book_format": bookFormat,
        "book_isbn": bookIsbn,
        "book_pages": bookPages,
        "book_rating": bookRating,
        "book_rating_count": bookRatingCount,
        "book_review_count": bookReviewCount,
        "book_title": bookTitle,
        "genres": genres,
        "image_url": imageUrl,
    };
}
