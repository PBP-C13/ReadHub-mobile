// To parse this JSON data, do
//
//     final favorit = favoritFromJson(jsonString);

import 'dart:convert';

List<Favorit> favoritFromJson(String str) => List<Favorit>.from(json.decode(str).map((x) => Favorit.fromJson(x)));

String favoritToJson(List<Favorit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favorit {
    Model model;
    int pk;
    Fields fields;

    Favorit({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Favorit.fromJson(Map<String, dynamic> json) => Favorit(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String bookAuthors;
    String? bookDesc;
    String? bookEdition;
    BookFormat bookFormat;
    String? bookIsbn;
    String bookPages;
    double bookRating;
    int bookRatingCount;
    int bookReviewCount;
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
        bookFormat: bookFormatValues.map[json["book_format"]]!,
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
        "book_format": bookFormatValues.reverse[bookFormat],
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

enum BookFormat {
    EBOOK,
    HARDCOVER,
    MASS_MARKET_PAPERBACK,
    PAPERBACK
}

final bookFormatValues = EnumValues({
    "ebook": BookFormat.EBOOK,
    "Hardcover": BookFormat.HARDCOVER,
    "Mass Market Paperback": BookFormat.MASS_MARKET_PAPERBACK,
    "Paperback": BookFormat.PAPERBACK
});

enum Model {
    BOOK_BOOK
}

final modelValues = EnumValues({
    "book.book": Model.BOOK_BOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
