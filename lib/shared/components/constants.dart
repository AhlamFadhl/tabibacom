import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tabibacom_doctor/models/category_model.dart';
import 'package:tabibacom_doctor/models/doctors_hospital_model.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/models/type_model.dart';
import 'package:tabibacom_doctor/models/users_model.dart';
import 'package:tabibacom_doctor/shared/network/local/cache_helper.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

const String KeyUserNo = 'key_usrno_doc';
const String KeyUserName = 'key_usrname_doc';
const String KeyUserEmail = 'key_usremail_doc';
const String KeyUserPhone = 'key_usrphone_doc';
const String KeyUserPass = 'key_usrpass_doc';
Users? user_doctor;

bool isLogin = true;

List<TypeModel> list_type_attend = [
  TypeModel(type_id: 1, type_name: 'حسب الموعد المحدد'),
  TypeModel(type_id: 2, type_name: 'اسبقية الحضور'),
];

List<TypeModel> list_type_appoint = [
  TypeModel(type_id: 1, type_name: 'يومي'),
  TypeModel(type_id: 7, type_name: 'اسبوعي'),
  TypeModel(type_id: 21, type_name: 'ثلاث اسابيع'),
  TypeModel(type_id: 28, type_name: 'اربع اسابيع'),
];

List<TypeModel> list_periods = [
  TypeModel(type_id: 5, type_name: '5 دقائق'),
  TypeModel(type_id: 10, type_name: '10 دقائق'),
  TypeModel(type_id: 15, type_name: '15 دقيقة'),
  TypeModel(type_id: 20, type_name: '20 دقيقة'),
  TypeModel(type_id: 25, type_name: '25 دقيقة'),
  TypeModel(type_id: 30, type_name: '30 دقيقة'),
  TypeModel(type_id: 40, type_name: '40 دقيقة'),
  TypeModel(type_id: 45, type_name: '45 دقيقة'),
  TypeModel(type_id: 60, type_name: '60 دقيقة'),
  TypeModel(type_id: 75, type_name: '75 دقيقة'),
  TypeModel(type_id: 90, type_name: '90 دقيقة'),
  TypeModel(type_id: 105, type_name: '105 دقيقة'),
  TypeModel(type_id: 120, type_name: '120 دقيقة'),
];

List<TypeModel> list_type_card = [
  TypeModel(type_id: 1, type_name: 'بطاقة شخصيه'),
  TypeModel(type_id: 2, type_name: 'جواز سفر'),
];

// enum
enum RecoredStatus { COMPLETE, REVIEW, ALL }

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = primaryColor;
      break;
    case ToastStates.ERROR:
      color = textErrorColor;
      break;
    case ToastStates.WARNING:
      color = warringColor;
      break;
  }

  return color;
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String getDayName(int dayno) {
  if (dayno == 1)
    return 'السبت';
  else if (dayno == 2)
    return 'الأحد';
  else if (dayno == 3)
    return 'الأثنين';
  else if (dayno == 4)
    return 'الثلاثاء';
  else if (dayno == 5)
    return 'الأربعاء';
  else if (dayno == 6)
    return 'الخميس';
  else if (dayno == 7)
    return 'الجمعه';
  else
    return '';
}

convertIntToTime(int time) {}
String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}

List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  final daysToGenerate = endDate.difference(startDate).inDays + 1;
  return List.generate(daysToGenerate, (i) => startDate.add(Duration(days: i)));
}

DateTime getDateTime(DateTime date, int min) {
  //'${date.year}-${date.month}-${date.day} 00:00:00'

  return (DateTime.parse(
          '${date.year}-${NumberFormat('00').format(date.month)}-${NumberFormat('00').format(date.day)} 00:00:00'))
      .add(Duration(minutes: min));
}
