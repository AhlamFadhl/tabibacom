class AppointmentDetails {
  int id;
  int apnt_no;
  int doc_no;
  int hsptl_no;
  int apnt_day; //ايام الاسبوع
  String apnt_from_time;
  String apnt_to_time;
  int apnt_count; //عدد الحجوزات
  int apnt_period;
  int apnt_avalible;

  int? apnt_type; //يومي او اسبوعي
  int? apnt_prevent; //يمنع الحجز
  int? attend_way;

  AppointmentDetails({
    required this.id,
    required this.apnt_no,
    required this.doc_no,
    required this.hsptl_no,
    required this.apnt_day,
    required this.apnt_from_time,
    required this.apnt_to_time,
    required this.apnt_count,
    required this.apnt_period,
    required this.apnt_avalible,
    this.apnt_type,
    this.apnt_prevent,
    this.attend_way,
  });

  factory AppointmentDetails.fromJson(Map<String, dynamic> json) {
    return AppointmentDetails(
      id: json['id'],
      apnt_no: json['apnt_no'],
      doc_no: json['doc_no'],
      hsptl_no: json['hsptl_no'],
      apnt_day: json['apnt_day'],
      apnt_from_time: json['apnt_from_time'],
      apnt_to_time: json['apnt_to_time'],
      apnt_count: json['apnt_count'],
      apnt_period: json['apnt_period'],
      apnt_avalible: json['apnt_avalible'],
      apnt_type: json['apnt_type'],
      apnt_prevent: json['apnt_prevent'],
      attend_way: json['attend_way'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apnt_no': apnt_no,
      'doc_no': doc_no,
      'hsptl_no': hsptl_no,
      'apnt_day': apnt_day,
      'apnt_from_time': apnt_from_time,
      'apnt_to_time': apnt_to_time,
      'apnt_count': apnt_count,
      'apnt_period': apnt_period,
      'apnt_avalible': apnt_avalible,
      'apnt_type': apnt_type,
      'apnt_prevent': apnt_prevent,
      'attend_way': attend_way,
    };
  }
}
