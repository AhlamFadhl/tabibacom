// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tabibacom_doctor/models/appointment_model.dart';
import 'package:tabibacom_doctor/models/doctors_hospital_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/models/patient_model.dart';
import 'package:tabibacom_doctor/models/sub_categories.dart';

class Doctor {
  int doc_no;
  String doc_first_name;
  String doc_last_name;
  String? doc_specialist;
  String doc_image;
  String doc_desc;
  String? doc_expirence;
  String? doc_images;
  int doc_gender;
  String doc_birth_day;

  int cat_no;
  int doc_naming;
  int? doc_phone_exist;
  int? doc_text_exist;
  int doc_user;
  String? doc_license_img;

  String doc_date_joined;
  List<SubCategories>? subcatogries;
  List<PatientsDoctor>? patients = [];

//////
  String? cat_name;
  dynamic? doc_price;
  int? avg_time;
  String? doc_note;
  List<Hospital>? lstHospital;
  Hospital? hospital_owner;

  //hospital
  int? hsptl_no;
  String? hsptl_name;
  String? hsptl_logo;
  String? hsptl_address;

  Doctor({
    required this.doc_no,
    this.doc_first_name = '',
    this.doc_last_name = '',
    this.doc_specialist,
    this.doc_image = '',
    this.doc_desc = '',
    this.doc_expirence,
    this.doc_images = '',
    this.doc_gender = 0,
    required this.doc_birth_day,
    required this.cat_no,
    this.doc_naming = 1,
    this.doc_phone_exist,
    this.doc_text_exist,
    required this.doc_user,
    this.doc_license_img,
    required this.doc_date_joined,
    this.subcatogries,
    this.patients,
    this.cat_name,
    this.doc_price,
    this.avg_time,
    this.doc_note,
    this.lstHospital,
    this.hospital_owner,
    this.hsptl_no,
    this.hsptl_name,
    this.hsptl_logo,
    this.hsptl_address,
  });

  factory Doctor.fromJson(Map<String, dynamic> json1) {
    return Doctor(
      doc_no: json1['doc_no'],
      doc_first_name: json1['doc_first_name'],
      doc_last_name: json1['doc_last_name'],
      doc_image: json1['doc_image'],
      doc_desc: json1['doc_desc'],
      doc_expirence: json1['doc_expirence'],
      doc_images: json1['doc_images'],
      doc_specialist: json1['doc_specialist'],
      cat_no: json1['cat_no'],
      doc_naming: json1['doc_naming'] ?? 1,
      doc_phone_exist: json1['doc_phone_exist'] ?? 0,
      doc_text_exist: json1['doc_text_exist'] ?? 0,
      lstHospital: json1.containsKey('hospitals')
          ? (json1['hospitals'] as List<dynamic>)
              .map((e) => Hospital.fromJson(e))
              .toList()
          : null,
      hospital_owner: json1.containsKey('hospital_owner')
          ? Hospital.fromJson(json1['hospital_owner'])
          : null,
      doc_date_joined: json1['doc_date_joined'],
      doc_user: json1['doc_user'],
      doc_gender: json1['doc_gender'],
      doc_birth_day: json1['doc_birth_day'],
      doc_license_img: json1['doc_license_img'],
///////////////
      cat_name: json1.containsKey('cat_name') ? json1['cat_name'] : '',
      doc_price: json1.containsKey('doc_price') ? json1['doc_price'] : '',
      avg_time: json1.containsKey('avg_time') ? (json1['avg_time'] ?? 0) : 0,
      hsptl_no: json1.containsKey('hsptl_no') ? json1['hsptl_no'] : 0,
      doc_note: json1.containsKey('doc_note') ? json1['doc_note'] : '',

      /////hospital
      hsptl_name: json1.containsKey('hsptl_name') ? json1['hsptl_name'] : '',
      hsptl_logo: json1.containsKey('hsptl_logo') ? json1['hsptl_logo'] : '',
      hsptl_address:
          json1.containsKey('hsptl_address') ? json1['hsptl_address'] : '',

      subcatogries: json1.containsKey('subcatogries')
          ? (json1['subcatogries'] as List<dynamic>)
              .map((e) => SubCategories.fromJson(e))
              .toList()
          : [],
      patients: json1.containsKey('patients')
          ? (json1['patients'] as List<dynamic>)
              .map((e) => PatientsDoctor.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doc_no': doc_no,
      'doc_desc': doc_desc,
      'doc_expirence': doc_expirence,
      'doc_images': doc_images,
      'doc_first_name': doc_first_name,
      'doc_last_name': doc_last_name,
      'doc_image': doc_image,
      'doc_specialist': doc_specialist,
      'cat_no': cat_no,
      'doc_naming': doc_naming,

      'doc_phone_exist': doc_phone_exist,
      'doc_text_exist': doc_text_exist,
      'doc_date_joined': doc_date_joined,
      'doc_user': doc_user,
      'doc_gender': doc_gender,
      'doc_birth_day': doc_birth_day,
      'doc_license_img': doc_license_img,
      //////
      'cat_name': cat_name,
      'doc_price': doc_price,
      'avg_time': avg_time,
      'hsptl_no': hsptl_no,
      'doc_note': doc_note,

      ////hospital
      'hsptl_name': hsptl_name,
      'hsptl_address': hsptl_address,
      'hsptl_logo': hsptl_logo,
      'subcatogries': subcatogries,
    };
  }
}
