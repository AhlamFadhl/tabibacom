class BookDetails {
  int book_no;
  int book_state;
  String datetime_enter;
  int book_user;

  BookDetails({
    required this.book_no,
    required this.book_state,
    required this.datetime_enter,
    this.book_user = 0,
  });

  factory BookDetails.fromJson(Map<String, dynamic> json) {
    return BookDetails(
      book_no: json['book_no'],
      book_state: json['book_state'],
      datetime_enter: json['datetime_enter'],
      book_user: json['book_user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book_no': book_no,
      'book_state': book_state,
      'datetime_enter': datetime_enter,
      'book_user': book_user,
    };
  }
}
