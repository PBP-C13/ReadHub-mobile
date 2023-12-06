import 'package:flutter/material.dart';
import 'package:readhub/models/book.dart';


class BookSelector extends StatelessWidget {
  final List<Book> books;
  final Function(String) onSelected;

  const BookSelector({Key? key, required this.books, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(books[index].fields.bookTitle),
          onTap: () => onSelected(books[index].pk as String),
        );
      },
    );
  }
}
