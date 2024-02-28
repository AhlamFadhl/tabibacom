class Services {
  int? id;
  int srv_no;
  String srv_name;
  int srv_type;
  int srv_cat;
  int? doc_no;
  int? hsptl_no;
  dynamic? srv_price;

  Services({
    this.id,
    required this.srv_no,
    required this.srv_name,
    required this.srv_type,
    required this.srv_cat,
    this.doc_no,
    this.hsptl_no,
    this.srv_price,
  });

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      id: json['id'],
      srv_no: json['srv_no'],
      srv_name: json['srv_name'],
      srv_type: json['srv_type'],
      srv_cat: json['srv_cat'],
      doc_no: json['doc_no'],
      hsptl_no: json['hsptl_no'],
      srv_price: json['srv_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'srv_no': srv_no,
      'srv_name': srv_name,
      'srv_type': srv_type,
      'doc_no': doc_no,
      'hsptl_no': hsptl_no,
      'srv_price': srv_price,
    };
  }
}
