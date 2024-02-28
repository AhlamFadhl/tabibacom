import 'dart:convert';

import 'package:tabibacom_doctor/models/appointment_details_model.dart';
import 'package:tabibacom_doctor/models/hospital_images_model.dart';
import 'package:tabibacom_doctor/models/services_model.dart';

class Hospital {
  int hsptl_no;
  String hsptl_name;
  String hsptl_dscr;
  String? hsptl_logo;
  String? hsptl_images;
  String? hsptl_address;
  String? hsptl_email;
  String? hsptl_face;
  String? hsptl_insta;
  String? hsptl_site;
  String? hsptl_phone_whats;
  String? hsptl_phone_call;
  String? hsptl_phone_other;
  String hsptl_date_joined;
  int hsptl_type;
  List<AppointmentDetails> appointments = [];
  List<HospitalImages> images = [];
  int? doc_owner;
  dynamic? doc_price;
  dynamic? doc_price_phone;
  dynamic? doc_price_visit;

  String? doc_note;
  int? doc_publish;
  int doc_no;
  int avg_time;
  bool isadded;
  bool isLoading;

  List<Services>? services = [];

  Hospital({
    required this.hsptl_no,
    required this.hsptl_name,
    this.hsptl_dscr = '',
    this.hsptl_logo = '',
    this.hsptl_images = '',
    this.hsptl_address = '',
    this.hsptl_email = '',
    this.hsptl_face = '',
    this.hsptl_insta = '',
    this.hsptl_site = '',
    this.hsptl_phone_whats = '',
    this.hsptl_phone_call = '',
    this.hsptl_phone_other = '',
    required this.hsptl_date_joined,
    required this.hsptl_type,
    required this.appointments,
    required this.images,
    this.doc_owner = 0,
    this.doc_price = 0,
    this.doc_price_phone = 0,
    this.doc_price_visit = 0,
    this.doc_note = '',
    this.doc_publish = 0,
    this.doc_no = 0,
    this.avg_time = 0,
    this.services,
    this.isadded = false,
    this.isLoading = false,
  });
  factory Hospital.fromJson(Map<String, dynamic> json1) {
    return Hospital(
      hsptl_no: json1['hsptl_no'],
      hsptl_name: json1['hsptl_name'],
      hsptl_dscr: json1['hsptl_dscr'],
      hsptl_logo: json1['hsptl_logo'],
      hsptl_images: json1['hsptl_images'],
      hsptl_address: json1['hsptl_address'],
      hsptl_email: json1['hsptl_email'],
      hsptl_face: json1['hsptl_face'],
      hsptl_insta: json1['hsptl_insta'],
      hsptl_site: json1['hsptl_site'],
      hsptl_phone_whats: json1['hsptl_phone_whats'],
      hsptl_phone_call: json1['hsptl_phone_call'],
      hsptl_phone_other: json1['hsptl_phone_other'],
      hsptl_date_joined: json1['hsptl_date_joined'],
      hsptl_type: json1['hsptl_type'],
      appointments: json1.containsKey('appointments')
          ? ((json1['appointments'] as List<dynamic>)
              .map((j) => AppointmentDetails.fromJson(j))).toList()
          : (json1.containsKey('apnt_from_time')
              ? [AppointmentDetails.fromJson(json1)]
              : []),
      doc_owner: json1.containsKey('doc_owner') ? json1['doc_owner'] : 0,
      doc_price: json1.containsKey('doc_price') ? json1['doc_price'] : 0,
      doc_price_phone:
          json1.containsKey('doc_price_phone') ? json1['doc_price_phone'] : 0,
      doc_price_visit:
          json1.containsKey('doc_price_visit') ? json1['doc_price_visit'] : 0,
      doc_note: json1.containsKey('doc_note') ? json1['doc_note'] : '',
      doc_publish: json1.containsKey('doc_publish') ? json1['doc_publish'] : 0,
      avg_time: json1.containsKey('avg_time') ? json1['avg_time'] : 0,
      services: json1.containsKey('services')
          ? ((json1['services'] as List<dynamic>)
              .map((j) => Services.fromJson(j))).toList()
          : null,
      images: json1.containsKey('images')
          ? ((json1['images'] as List<dynamic>)
              .map((j) => HospitalImages.fromJson(j))).toList()
          : [],
      isadded: json1.containsKey('isadded')
          ? (json1['isadded'] == 0 ? false : true)
          : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hsptl_no': hsptl_no,
      'hsptl_name': hsptl_name,
      'hsptl_dscr': hsptl_dscr,
      'hsptl_logo': hsptl_logo,
      'hsptl_images': hsptl_images,
      'hsptl_address': hsptl_address,
      'hsptl_email': hsptl_email,
      'hsptl_face': hsptl_face,
      'hsptl_insta': hsptl_insta,
      'hsptl_site': hsptl_site,
      'hsptl_phone_whats': hsptl_phone_whats,
      'hsptl_phone_call': hsptl_phone_call,
      'hsptl_phone_other': hsptl_phone_other,
      'hsptl_date_joined': hsptl_date_joined,
      'hsptl_type': hsptl_type,
      'doc_no': doc_no,
      'avg_time': avg_time,
      'doc_owner': doc_owner,
      'doc_price': doc_price,
      'doc_price_phone': doc_price_phone,
      'doc_price_visit': doc_price_visit,
      'doc_note': doc_note,
      'doc_publish': doc_publish,
      'services': services,
      'isadded': isadded,
    };
  }
}
