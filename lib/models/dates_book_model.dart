import 'package:tabibacom_doctor/models/book_model.dart';

class DatesBook {
  int book_count;
  String book_date;
  List<BookModel> list_book;

  DatesBook({
    required this.book_count,
    required this.book_date,
    required this.list_book,
  });

  factory DatesBook.fromJson(Map<String, dynamic> json) {
    return DatesBook(
      book_count: json['book_count'],
      book_date: json['book_date'],
      list_book: json['list_book'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book_count': book_count,
      'book_date': book_date,
      'list_book': list_book,
    };
  }
}
