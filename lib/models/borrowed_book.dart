// To parse this JSON data, do
//
//     final borrowedBook = borrowedBookFromJson(jsonString);

import 'dart:convert';
import 'package:readhub/models/book.dart';

List<BorrowedBook> borrowedBookFromJson(String str) => List<BorrowedBook>.from(json.decode(str).map((x) => BorrowedBook.fromJson(x)));

String borrowedBookToJson(List<BorrowedBook> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BorrowedBook {
    int? user;
    Book? book;
    int? borrowDuration;
    DateTime? borrowDate;
    DateTime? returnDate;

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
        "book": book?.toJson(),
        "borrow_duration": borrowDuration,
        "borrow_date": "${borrowDate?.year.toString().padLeft(4, '0')}-${borrowDate?.month.toString().padLeft(2, '0')}-${borrowDate?.day.toString().padLeft(2, '0')}",
        "return_date": "${returnDate?.year.toString().padLeft(4, '0')}-${returnDate?.month.toString().padLeft(2, '0')}-${returnDate?.day.toString().padLeft(2, '0')}",
    };
}