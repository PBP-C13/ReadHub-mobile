// To parse this JSON data, do
//
//     final bookFavorit = bookFavoritFromJson(jsonString);

import 'dart:convert';

List<BookFavorit> bookFavoritFromJson(String str) => List<BookFavorit>.from(json.decode(str).map((x) => BookFavorit.fromJson(x)));

String bookFavoritToJson(List<BookFavorit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookFavorit {
    int user;
    Book books;
    String nameCategory;
    bool isFavorit;

    BookFavorit({
        required this.user,
        required this.books,
        required this.nameCategory,
        required this.isFavorit,
    });

    factory BookFavorit.fromJson(Map<String, dynamic> json) => BookFavorit(
        user: json["user"],
        books: Book.fromJson(json["books"]),
        nameCategory: json["name_category"],
        isFavorit: json["is_favorit"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "books": books.toJson(),
        "name_category": nameCategory,
        "is_favorit": isFavorit,
    };
}

class Book {
    int id;
    String bookAuthors;
    String bookDesc;
    String? bookEdition;
    String bookFormat;
    String bookIsbn;
    String bookPages;
    double bookRating;
    int bookRatingCount;
    int bookReviewCount;
    String bookTitle;
    String genres;
    String imageUrl;

    Book({
        required this.id,
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

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
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
        "id": id,
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
