import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:tabibacom_doctor/models/book_details_model.dart';
import 'package:tabibacom_doctor/models/book_model.dart';
import 'package:tabibacom_doctor/models/dates_book_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

part 'states.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsStatess> {
  MyAppointmentsCubit() : super(MyAppointmentsInitial());

  final _controller = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get stream1 => _controller.stream;

  static MyAppointmentsCubit get(context) => BlocProvider.of(context);
  bool isLoading = true;
  List<BookModel> list_book_today = [];
  List<BookModel> list_book_history = [];
  //List<DatesBook> list_dates_today = [];
  List<DatesBook> list_dates_history = [];
  List<Hospital> hospital_today = [];

  int typeStyle = 1;
  changeStyleShowList(value) {
    typeStyle = value;
    getHospitalDataToday(DateTime.now(), user_doctor!.doctor!.doc_no);
  }

  getBookAppoientmens(doc, date1, date2) {
    String date_temp = '';
    List<BookModel> list_book_temp = [];
    List<BookModel> list_book = [];
    list_book_today = [];

    list_book_history = [];
    list_dates_history = [];

    emit(MyAppointmentsLoading());
    DioHelper.postData(url: BOOK_DOCTOR, data: {
      'doc': doc,
      'date1': DateFormat('yyyy-MM-dd').format(date1),
      'date2': DateFormat('yyyy-MM-dd').format(date2),
    }).then((value) {
      print(value);
      if (value.statusCode == 200) {
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
                      DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(date_temp)))
                  .toList();
              list_dates_history.add(DatesBook(
                  book_count: list_book_temp.length,
                  book_date: date_temp,
                  list_book: list_book_temp));
            }
          });
        }
        isLoading = false;
        emit(MyAppointmentsGet());
      }
      isLoading = false;
      emit(MyAppointmentsFailed());
    }).catchError((error) {
      print(error);
      isLoading = false;
      emit(MyAppointmentsError());
    });
  }

  getHospitalDataToday(DateTime date, doc) {
    isLoading = true;
    emit(MyAppointmentsLoading());
    DioHelper.postData(
            url: APPONTMENT_DETAILS_HOSPITAL,
            data: {'day': convertWeekDayNo(date.weekday), 'doc': doc})
        .then((value) {
      print(value);
      if (value.statusCode == 200) {
        List<dynamic> list = value.data;
        hospital_today = list.map((e) => Hospital.fromJson(e)).toList();
        isLoading = false;
        emit(MyAppointmentsGet());
      } else {
        isLoading = false;
        emit(MyAppointmentsGet());
      }
      _controller.sink.add(SwipeRefreshState.hidden);
    }).catchError((error) {
      isLoading = false;
      print(error);
      _controller.sink.add(SwipeRefreshState.hidden);
      emit(MyAppointmentsError());
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
        emit(MyAppointmentsGet());
      } else {
        emit(MyAppointmentsFailed());
      }
    }).catchError((error) {
      print(error);
      emit(MyAppointmentsError());
    });
  }
}
