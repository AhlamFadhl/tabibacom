import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:tabibacom_doctor/models/book_details_model.dart';
import 'package:tabibacom_doctor/models/book_model.dart';
import 'package:tabibacom_doctor/models/dates_book_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/screens/home/home_page.dart';
import 'package:tabibacom_doctor/screens/my_appointments/my_transactions_page.dart';
import 'package:tabibacom_doctor/screens/settings/settings_page.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/layout/home/cubit/states.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/local/cache_helper.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppintialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    HomePage(),
    MyAppointmentsPage(),
    SettingsPage(),
  ];
  List<String> titles = [
    'الرئيسية',
    'حجوزاتي',
    'الإعدادات',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<BookModel> list_book_today = [];
  List<BookModel> list_book_history = [];
  //List<DatesBook> list_dates_today = [];
  List<DatesBook> list_dates_history = [];
  Hospital? hospital_today;

  getBookAppoientmens(doc, date1, date2) {
    String date_temp = '';
    List<BookModel> list_book_temp = [];
    List<BookModel> list_book = [];
    list_book_today = [];

    list_book_history = [];
    list_dates_history = [];

    emit(AppLoadingMyAppoientmentsState());
    DioHelper.postData(
        url: BOOK_DOCTOR,
        data: {'doc': doc, 'date1': date1, 'date2': date2}).then((value) {
      print(value);
      List<dynamic> list = value.data;
      list_book = list.map((json) => BookModel.fromJson(json)).toList();
      list_book_today = list_book
          .where((element) =>
              DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(element.book_date)) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now()))
          .toList();
      list_book_history = list_book
          .where((element) =>
              DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(element.book_date)) !=
              DateFormat('yyyy-MM-dd').format(DateTime.now()))
          .toList();
      if (list_book_history.length > 0) {
        list_book_history.forEach((element) {
          if (element.book_date != date_temp) {
            date_temp = DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(element.book_date));
            list_book_temp = list_book_history
                .where((e) =>
                    DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(e.book_date)) ==
                    DateFormat('yyyy-MM-dd').format(DateTime.parse(date_temp)))
                .toList();
            list_dates_history.add(DatesBook(
                book_count: list_book_temp.length,
                book_date: date_temp,
                list_book: list_book_temp));
          }
        });
      }
      emit(AppSucessMyAppoientmentsState());
    }).catchError((error) {
      print(error);
      emit(AppErrorMyAppoientmentsState());
    });
  }

  getHospitalDataToday(DateTime date, doc) {
    emit(AppLoadingMyAppoientmentsState());
    DioHelper.postData(
        url: APPONTMENT_DETAILS_HOSPITAL,
        data: {'day': date.weekday + 2, 'doc': doc}).then((value) {
      print(value);
      hospital_today = Hospital.fromJson(value.data);
      emit(AppSucessMyAppoientmentsState());
    }).catchError((error) {
      print(error);
      emit(AppErrorMyAppoientmentsState());
    });
  }

  updateStatusBookAppointment(index, state, BookModel book) {
    BookDetails details = BookDetails(
        book_no: book.book_no,
        book_state: state,
        book_user: user_doctor!.usr_no,
        datetime_enter: DateTime.now().toString());
    DioHelper.postData(url: BOOK_DETAILS_NEW, data: details.toJson())
        .then((value) {
      if (value.data['status'] == 1) {
        list_book_today[index].book_state = state;
        emit(AppSucessMyAppoientmentsState());
      } else {
        emit(AppFailedMyAppoientmentsState());
      }
    }).catchError((error) {
      print(error);
      emit(AppErrorMyAppoientmentsState());
    });
  }
}
