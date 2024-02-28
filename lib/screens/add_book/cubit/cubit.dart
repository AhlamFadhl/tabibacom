import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:tabibacom_doctor/models/book_model.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/patient_model.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

part 'states.dart';

class AddBookCubit extends Cubit<AddBookState> {
  AddBookCubit({required this.book_date, this.book_time})
      : super(AddBookInitial());

  static AddBookCubit get(context) => BlocProvider.of(context);

  PatientsDoctor? patient;
  DateTime book_date;
  DateTime? book_time;
  String? book_note;
  TextEditingController controllerNote = TextEditingController();
  var keyForm = GlobalKey<FormState>();
  selectPatient(value) {
    patient = value;
    emit(AddBookSelectPatinet());
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: book_date,
      firstDate: DateTime(000),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (picked != null) {
      book_date = picked;
      emit(AddBookSelectDate());
    }
  }

  Future<void> selectTime(context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: book_time == null
          ? TimeOfDay.now()
          : TimeOfDay.fromDateTime(book_time!),
    );
    if (selectedTime != null) {
      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: true);

      if (formattedTime != null) {
        book_time = DateTime.tryParse(
            DateFormat('yyyy-MM-dd').format(DateTime.now()) +
                ' ' +
                formattedTime);
      }
      emit(AddBookSelectTime());
    }
  }

  setTime(time) async {
    book_time = time;
    emit(AddBookSelectTime());
  }

  insertBookAppoinment(BookModel book, context) async {
    if (await checkInternet()) {
      ProgressDialog prg = customProgressDialog(context);
      prg.show();
      try {
        var value =
            await DioHelper.postData(url: BOOK_NEW, data: book.toJson());
        if (value.statusCode == 200) {
          if (value.data['status'] == 1) {
            Get.back(result: value.data['status']);
          } else {
            showToast(text: 'حدث خطأ اثناء الحفظ', state: ToastStates.ERROR);
          }
        } else {
          showToast(text: 'حدث خطأ اثناء الحفظ', state: ToastStates.ERROR);
        }
      } catch (error) {
        print(error);
        showToast(text: 'تأكد من الانترنت', state: ToastStates.ERROR);
      }
      prg.hide();
    }
  }
}
