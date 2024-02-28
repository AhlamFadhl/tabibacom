import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:tabibacom_doctor/models/patient_model.dart';
import 'package:tabibacom_doctor/models/type_model.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

part 'states.dart';

class PatientsCubit extends Cubit<PatientsState> {
  PatientsCubit() : super(PatientsInitial());
  static PatientsCubit get(context) => BlocProvider.of(context);

  final _controller = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get stream1 => _controller.stream;

  bool isLoading = true;
  List<PatientsDoctor> list_patients = [];
  List<PatientsDoctor> list_patients_all = [];
  PatientsDoctor? patientsDoctor;
  getPatientsDoctor(doc) {
    emit(PatientsLoadingState());
    DioHelper.postData(url: PATIENTSDOCTOR_GET, data: {'doc_no': doc})
        .then((value) {
      print(value);
      List<dynamic> list = value.data;
      list_patients =
          list.map((json) => PatientsDoctor.fromJson(json)).toList();
      list_patients_all = list_patients;
      _controller.sink.add(SwipeRefreshState.hidden);
      isLoading = false;
      emit(PatientsGetState());
    }).catchError((error) {
      print(error);
      isLoading = false;
      emit(PatientsErrorState());
      _controller.sink.add(SwipeRefreshState.hidden);
    });
  }

  setDataToEdit() {
    if (patientsDoctor != null) {
      controller_name.text = patientsDoctor!.ptn_name;
      controller_no.text = patientsDoctor!.ptn_no.toString();
      controller_note.text = patientsDoctor!.ptn_note;
      controller_email.text = patientsDoctor!.ptn_email ?? '';
      controller_idcard.text = patientsDoctor!.ptn_idcard;
      controller_date.text = patientsDoctor!.ptn_birthday;
      select_gender = patientsDoctor!.ptn_gender;
      dropdownValueType = list_type_card
          .where((element) => element.type_id == patientsDoctor!.ptn_typecard)
          .toList()[0];
      emit(PatientsSetDataEditState());
    }
  }

  SearchPatients(value) {
    list_patients = list_patients_all
        .where((element) => (element.ptn_name.contains(value) ||
            element.ptn_no.toString().contains(value) ||
            (element.ptn_email ?? '').contains(value)))
        .toList();
    emit(PatientsGetState());
  }

  TypeModel dropdownValueType = list_type_card[0];
  changeCard_type(newValue) {
    dropdownValueType = newValue;
    emit(PatientsChangeCardTypeState());
  }

  int select_gender = 0;
  setChangeGender(value) {
    select_gender = value;
    emit(PatientsChangeGenderState());
  }

  Future<void> selectDate(BuildContext context, DateTime? date) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (date != null && date.year > 0000)
          ? date
          : DateTime.now().add(Duration(days: -360)),
      firstDate: DateTime(000),
      lastDate: DateTime(DateTime.now().year),
    );

    if (picked != null) {
      controller_date.text = DateFormat.yMMMd().format(picked);
      emit(PatientsChangeDateState());
    }
  }

  var controller_name = TextEditingController();
  var controller_no = TextEditingController();
  var controller_email = TextEditingController();
  var controller_date = TextEditingController();
  var controller_idcard = TextEditingController();
  var controller_note = TextEditingController();

  var formKey = GlobalKey<FormState>();
  inserttPatientsDoctor(PatientsDoctor ptnt) async {
    if (formKey.currentState!.validate()) {
      if (await checkInternet()) {
        emit(PatientsSavingState());

        DioHelper.postData(url: PATIENTSDOCTOR_NEW, data: ptnt.toJson())
            .then((value) {
          if (value.statusCode == 200) {
            if (value.data["status"] == 1) {
              list_patients.add(PatientsDoctor.fromJson(value.data['patient']));
              user_doctor!.doctor!.patients = list_patients;
              controller_date.text = '';
              controller_email.text = '';
              controller_idcard.text = '';
              controller_name.text = '';
              controller_no.text = '';
              controller_note.text = '';
              emit(PatientsSavedState());
            } else if (value.data["status"] == -1) {
              emit(PatientsFailedSaveState());
            } else {
              emit(PatientsErrorSaveState());
            }
          } else {
            emit(PatientsErrorSaveState());
          }
        }).catchError((error) {
          print(error);
          emit(PatientsErrorSaveState());
        });
      }
    } else {
      emit(PatientsValidateFailedState());
    }
  }
}
