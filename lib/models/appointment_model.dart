import 'package:tabibacom_doctor/models/appointment_details_model.dart';

class Appointment {
  int apnt_no;
  int doc_no;
  int hsptl_no;
  int apnt_type; //يومي او اسبوعي
  int apnt_prevent; //يمنع الحجز
  int attend_way;
  List<AppointmentDetails>? details;

  Appointment({
    required this.apnt_no,
    required this.doc_no,
    required this.hsptl_no,
    required this.apnt_type,
    required this.apnt_prevent,
    required this.attend_way,
    this.details,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      apnt_no: json['apnt_no'],
      doc_no: json['doc_no'],
      hsptl_no: json['hsptl_no'],
      apnt_type: json['apnt_type'],
      apnt_prevent: json['apnt_prevent'],
      attend_way: json['attend_way'],
      details: json.containsKey('details')
          ? (json['details'] as List<dynamic>)
              .map((e) => AppointmentDetails.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apnt_no': apnt_no,
      'doc_no': doc_no,
      'hsptl_no': hsptl_no,
      'apnt_type': apnt_type,
      'apnt_prevent': apnt_prevent,
      'attend_way': attend_way,
      'details':
          details != null ? details!.map((e) => e.toJson()).toList() : null,
    };
  }
}
