import 'dart:convert';

Forum forumFromJson(String str) => Forum.fromJson(json.decode(str));

String forumToJson(Forum data) => json.encode(data.toJson());

class Forum {
    String name;
    int forumId;
    int likes;
    String forumText;
    String bookImage;
    String bookTitle;
    String bookAuthor;
    List<String> bookGenre;

    Forum({
        required this.name,
        required this.forumId,
        required this.likes,
        required this.forumText,
        required this.bookImage,
        required this.bookTitle,
        required this.bookAuthor,
        required this.bookGenre,
    });

    factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        name: json["name"],
        forumId: json["forum_id"],
        likes: json["likes"],
        forumText: json["forum_text"],
        bookImage: json["book_image"],
        bookTitle: json["book_title"],
        bookAuthor: json["book_author"],
        bookGenre: List<String>.from(json["book_genre"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "forum_id": forumId,
        "likes": likes,
        "forum_text": forumText,
        "book_image": bookImage,
        "book_title": bookTitle,
        "book_author": bookAuthor,
        "book_genre": List<dynamic>.from(bookGenre.map((x) => x)),
    };
}
