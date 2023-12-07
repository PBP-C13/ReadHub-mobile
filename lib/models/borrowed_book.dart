// To parse this JSON data, do
//
//     final borrowedBook = borrowedBookFromJson(jsonString);

import 'dart:convert';

List<BorrowedBook> borrowedBookFromJson(String str) => List<BorrowedBook>.from(json.decode(str).map((x) => BorrowedBook.fromJson(x)));

String borrowedBookToJson(List<BorrowedBook> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BorrowedBook {
    int user;
    Book book;
    int borrowDuration;
    DateTime borrowDate;
    DateTime returnDate;

    BorrowedBook({
        required this.user,
        required this.book,
        required this.borrowDuration,
        required this.borrowDate,
        required this.returnDate,
    });

    factory BorrowedBook.fromJson(Map<String, dynamic> json) => BorrowedBook(
        user: json["user"],
        book: Book.fromJson(json["book"]),
        borrowDuration: json["borrow_duration"],
        borrowDate: DateTime.parse(json["borrow_date"]),
        returnDate: DateTime.parse(json["return_date"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "book": book.toJson(),
        "borrow_duration": borrowDuration,
        "borrow_date": "${borrowDate.year.toString().padLeft(4, '0')}-${borrowDate.month.toString().padLeft(2, '0')}-${borrowDate.day.toString().padLeft(2, '0')}",
        "return_date": "${returnDate.year.toString().padLeft(4, '0')}-${returnDate.month.toString().padLeft(2, '0')}-${returnDate.day.toString().padLeft(2, '0')}",
    };
}

class Book {
    int id;
    String bookAuthors;
    String bookDesc;
    dynamic bookEdition;
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