import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:tabibacom_doctor/models/book_model.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_alret_dialog.dart';
import 'package:tabibacom_doctor/shared/components/utils/error_handler.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

part 'states.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit({required this.doctor, required this.hospital})
      : super(ScheduleInitial());

  static ScheduleCubit get(context) => BlocProvider.of(context);

  Doctor doctor;
  Hospital hospital;
  bool isLoadingHistory = true;
  bool isLoadingNext = true;
  List<BookModel> list_book_history = [];
  List<BookModel> list_book_next = [];

  final _controller = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get stream1 => _controller.stream;

  getBookHistory(doc, hsptl) {
    emit(ScheduleLoadingHistoryState());
    DioHelper.postData(
        url: BOOKHISTORY,
        data: {'doc_no': doc, 'hsptl_no': hsptl}).then((value) {
      print(value);
      if (value.statusCode == 200) {
        List<dynamic> list = value.data;
        list_book_history =
            list.map((json) => BookModel.fromJson(json)).toList();
        isLoadingHistory = false;
        emit(ScheduleGetHistoryState());
      }
      _controller.sink.add(SwipeRefreshState.hidden);
    }).catchError((error) {
      _controller.sink.add(SwipeRefreshState.hidden);
      ErrorHandler.handleError(error, showToast: true);
      isLoadingHistory = false;
      print(error);
      emit(ScheduleErrorHistoryState());
    });
  }

/////
  bool isLoading = false;
  DateTime lastDate = DateTime.now(); // Keep track of the current page
  final int itemsPerPage = 100;
  ScrollController scrollController = ScrollController();

  initalScrollController() {
    scrollController.addListener(_scrollListener);
  }

  // Scroll listener
  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // Scroll to the bottom, load more data
      getBookNextMore(doctor.doc_no, hospital.hsptl_no, lastDate,
          lastDate.add(const Duration(days: 30)));
    }
  }

  final _controller2 = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get stream2 => _controller.stream;

  getBookNext(doc, hsptl, date1, date2) {
    emit(ScheduleLoadingNextState());
    DioHelper.postData(url: BOOKNEXT, data: {
      'doc_no': doc,
      'hsptl_no': hsptl,
      'date1': date1.toString(),
      'date2': date2.toString(),
    }).then((value) {
      print(value);
      if (value.statusCode == 200) {
        List<dynamic> list = value.data;
        list_book_next = list.map((json) => BookModel.fromJson(json)).toList();
        lastDate = date2;
        isLoadingNext = false;
        emit(ScheduleGetNextState());
      } else {
        isLoadingNext = false;
        emit(ScheduleErrorNextState());
      }
      _controller2.sink.add(SwipeRefreshState.hidden);
    }).catchError((error) {
      _controller2.sink.add(SwipeRefreshState.hidden);
      print(error);
      ErrorHandler.handleError(error, showToast: true);
      isLoadingNext = false;
      emit(ScheduleErrorNextState());
    });
  }

  getBookNextMore(doc, hsptl, date1, date2) {
    isLoading = true;
    emit(ScheduleLoadingMoreNextState());
    DioHelper.postData(url: BOOKNEXT, data: {
      'doc_no': doc,
      'hsptl_no': hsptl,
      'date1': date1.toString(),
      'date2': date2.toString(),
    }).then((value) {
      print(value);
      List<dynamic> list = value.data;
      list_book_next
          .addAll(list.map((json) => BookModel.fromJson(json)).toList());
      lastDate = date2;
      isLoading = false;
      emit(ScheduleGetMoreNextState());
    }).catchError((error) {
      print(error);
      ErrorHandler.handleError(error, showToast: true);
      isLoading = false;
      emit(ScheduleErrorMoreNextState());
    });
  }

  alertShowHoliday(int indx, holy_no, context) async {
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: holy_no == 0 ? 'وضع إجازة' : 'الغاء وضع الإجازة',
        question: holy_no == 0
            ? 'هل أنت متأكد من جعل هذا التاريخ إجازة من العمل؟'
            : 'هل أنت متأكد من الغاء وضع الإجازة؟',
      ),
    );

    if (result != null && result) {
      // User clicked "Yes"
      if (await checkInternet()) {
        ProgressDialog prg = customProgressDialog(context,
            title: holy_no == 0
                ? 'جعل فتره الدوام هذه إجازة....'
                : 'يتم الغاء وضع الإجازة...');
        prg.show();
        int? holy = await setHoliday(list_book_next[indx]);
        if (holy != null) {
          list_book_next[indx].holy_no = holy;
        }
        emit(ScheduleDoneHolyState());
        prg.hide();
      }
    } else {
      // User clicked "No" or dialog was dismissed
    }
  }

  setHoliday(BookModel bok) async {
    isLoading = true;
    emit(ScheduleLoadingHolyState());
    try {
      var value = await DioHelper.postData(url: SETHOLIDAYDOCTOR, data: {
        'holy_no': bok.holy_no,
        'doc_no': doctor.doc_no,
        'hsptl_no': hospital.hsptl_no,
        'holy_date': bok.book_date,
        'holy_full_day': 1,
        'apnt_id': 0,
        'usr_no': user_doctor!.usr_no,
      });
      if (value.statusCode == 200) {
        emit(ScheduleDoneHolyState());
        if (value.data['status'] == 1) {
          return value.data['holy_no'];
        } else {
          return bok.holy_no;
        }
      } else {
        emit(ScheduleErrorHolyState());
      }
    } catch (error) {
      ErrorHandler.handleError(error, showToast: true);
      print(error);
      emit(ScheduleErrorHolyState());
    }
    return bok.holy_no;
  }
}
