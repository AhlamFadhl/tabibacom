import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tabibacom_doctor/models/book_model.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

part 'states.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit(
      {required this.doctor, required this.hospital, required this.currentDate})
      : super(BookDetailsInitial());
  static BookDetailsCubit get(context) => BlocProvider.of(context);
  Doctor doctor;
  Hospital hospital;
  List<BookModel> list_book_details = [];
  DateTime currentDate;
  int? recordsCount;
  getBookDetails() async {
    emit(BookDetailsLoadingState());
    if (await checkInternet()) {
      DioHelper.postData(url: BOOKDETAILS, data: {
        'doc_no': doctor.doc_no,
        'hsptl_no': hospital.hsptl_no,
        'date': currentDate.toString(),
      }).then((value) {
        print(value);
        List<dynamic> list = value.data;
        list_book_details =
            list.map((json) => BookModel.fromJson(json)).toList();
        recordsCount = list_book_details.length;
        emit(BookDetailsGetState());
      }).catchError((error) {
        print(error);
        emit(BookDetailsErrorState());
      });
    } else {
      emit(BookDetailsNoEnternetState());
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(000),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (picked != null) {
      currentDate = picked;
      getBookDetails();
    }
  }
}
