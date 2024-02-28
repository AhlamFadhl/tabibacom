class PatientsDoctor {
  int ptn_no;
  String ptn_name;
  String ptn_phone;
  String? ptn_email;
  int ptn_gender;
  String ptn_birthday;
  int ptn_typecard; // 1 بطاقة ,, 2 جواز
  String ptn_idcard;
  int ptn_user;
  int doc_no;
  String ptn_note;

  PatientsDoctor(
      {required this.ptn_no,
      required this.ptn_name,
      required this.ptn_phone,
      this.ptn_email,
      this.ptn_gender = 0,
      required this.ptn_birthday,
      this.ptn_typecard = 1,
      this.ptn_idcard = '',
      this.ptn_user = 0,
      this.doc_no = 0,
      this.ptn_note = ''});

  factory PatientsDoctor.fromJson(Map<String, dynamic> json) {
    return PatientsDoctor(
        ptn_no: json['ptn_no'],
        ptn_name: json['ptn_name'],
        ptn_phone: json['ptn_phone'],
        ptn_email: json['ptn_email'],
        ptn_gender: json['ptn_gender'],
        ptn_birthday: json['ptn_birthday'],
        ptn_typecard: json['ptn_typecard'],
        ptn_idcard: json['ptn_idcard'],
        ptn_user: json['ptn_user'],
        doc_no: json['doc_no'],
        ptn_note: json['ptn_note']);
  }

  Map<String, dynamic> toJson() {
    return {
      'ptn_no': ptn_no,
      'ptn_name': ptn_name,
      'ptn_phone': ptn_phone,
      'ptn_email': ptn_email,
      'ptn_gender': ptn_gender,
      'ptn_birthday': ptn_birthday,
      'ptn_typecard': ptn_typecard,
      'ptn_idcard': ptn_idcard,
      'ptn_user': ptn_user,
      'doc_no': doc_no,
      'ptn_note': ptn_note,
    };
  }
}
