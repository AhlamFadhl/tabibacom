class BookModel {
  int book_no;
  int doc_no;
  int hsptl_no;
  int usr_no;
  int book_for_you;
  int ptn_no;
  String pt_name;
  String pt_phone;
  int srv_no;
  dynamic book_price;
  String book_date;
  String book_time;
  String book_note;
  int book_state;
  String date_enter;
  int book_from_app;
  int book_count;
  int holy_no;

  BookModel({
    required this.book_no,
    required this.doc_no,
    required this.hsptl_no,
    required this.usr_no,
    required this.book_for_you,
    required this.ptn_no,
    required this.pt_name,
    required this.pt_phone,
    required this.srv_no,
    required this.book_price,
    required this.book_date,
    required this.book_time,
    this.book_note = '',
    required this.book_state,
    required this.date_enter,
    this.book_from_app = 0,
    this.book_count = 0,
    this.holy_no = 0,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      book_no: json.containsKey('book_no') ? json['book_no'] : 0,
      doc_no: json.containsKey('doc_no') ? json['doc_no'] : 0,
      hsptl_no: json.containsKey('hsptl_no') ? json['hsptl_no'] : 0,
      usr_no: json.containsKey('usr_no') ? json['usr_no'] : 0,
      book_for_you: json.containsKey('book_for_you') ? json['book_for_you'] : 0,
      ptn_no: json.containsKey('ptn_no') ? json['ptn_no'] : 0,
      pt_name: json.containsKey('pt_name') ? json['pt_name'] : '',
      pt_phone: json.containsKey('pt_phone') ? json['pt_phone'] : '',
      srv_no: json.containsKey('srv_no') ? json['srv_no'] : 1,
      book_price: json.containsKey('book_price') ? json['book_price'] : 0,
      book_date: json.containsKey('book_date') ? json['book_date'] : '',
      book_time: json.containsKey('book_time') ? json['book_time'] : '',
      book_note: json.containsKey('book_note') ? json['book_note'] : '',
      book_state: json.containsKey('book_state') ? json['book_state'] : 0,
      date_enter: json.containsKey('date_enter') ? json['date_enter'] : '',
      book_from_app:
          json.containsKey('book_from_app') ? json['book_from_app'] : 0,
      book_count: json.containsKey('book_count') ? json['book_count'] : 0,
      holy_no: json.containsKey('holy_no') ? json['holy_no'] : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book_no': book_no,
      'doc_no': doc_no,
      'hsptl_no': hsptl_no,
      'usr_no': usr_no,
      'book_for_you': book_for_you,
      'ptn_no': ptn_no,
      'pt_name': pt_name,
      'pt_phone': pt_phone,
      'srv_no': srv_no,
      'book_price': book_price,
      'book_date': book_date,
      'book_time': book_time,
      'book_note': book_note,
      'book_state': book_state,
      'date_enter': date_enter,
      'book_from_app': book_from_app,
      'book_count': book_count,
      'holy_no': 'holy_no',
    };
  }
}
