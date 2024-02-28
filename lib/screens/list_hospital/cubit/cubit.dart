import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/doctors_hospital_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_alret_dialog.dart';
import 'package:tabibacom_doctor/shared/components/utils/error_handler.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

part 'states.dart';

class ListHospitalCubit extends Cubit<ListHospitalState> {
  ListHospitalCubit() : super(ListHospitalInitial());

  final _controller = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get stream1 => _controller.stream;

  static ListHospitalCubit get(context) => BlocProvider.of(context);

  bool isLoading = true;
  List<Hospital> list_hospitals = [];
  List<Hospital> llist_hospitals_all = [];
  getHospitals() {
    emit(ListHospitalLoadingState());
    DioHelper.postData(
        url: HOSPITAL_DOCTOR_GET_ALL,
        data: {'doc_no': user_doctor!.doctor!.doc_no}).then((value) {
      print(value);
      List<dynamic> list = value.data;
      list_hospitals = list.map((json) => Hospital.fromJson(json)).toList();
      llist_hospitals_all = list_hospitals;
      isLoading = false;
      _controller.sink.add(SwipeRefreshState.hidden);
      emit(ListHospitalGetState());
    }).catchError((error) {
      isLoading = false;
      print(error);
      ErrorHandler.handleError(error);
      emit(ListHospitalErrorState());
      _controller.sink.add(SwipeRefreshState.hidden);
    });
  }

  SearchHospitals(value) {
    list_hospitals = llist_hospitals_all
        .where((element) => (element.hsptl_name.contains(value) ||
            element.hsptl_phone_call.toString().contains(value) ||
            (element.hsptl_address ?? '').contains(value)))
        .toList();
    emit(ListHospitalGetState());
  }

  alertShowHospital(int indx, context) async {
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: list_hospitals[indx].isadded ? 'حذف المركز' : 'إضافة المزكز',
        question: list_hospitals[indx].isadded
            ? 'هل أنت متأكد من حذف المزكز الطبي'
            : 'هل أنت متأكد من إضافة المزكز الطبي',
      ),
    );

    if (result != null && result) {
      // User clicked "Yes"
      if (await checkInternet()) {
        /*   ProgressDialog prg = customProgressDialog(context,
            title: isadded == 0
                ? 'جعل فتره الدوام هذه إجازة....'
                : 'يتم الغاء وضع الإجازة...');
        prg.show();*/
        list_hospitals[indx].isLoading = true;
        emit(ListHospitalSelectLoadingState());
        list_hospitals[indx].isadded =
            await addHospital(user_doctor!.doctor!, list_hospitals[indx]);

        list_hospitals[indx].isLoading = false;
        emit(ListHospitalSelectedState());
        //  prg.hide();
      }
    } else {
      // User clicked "No" or dialog was dismissed
    }
  }

  addHospital(Doctor doctor, Hospital hospital) async {
    try {
      Doctors_Hospital doctorshospital = Doctors_Hospital(
        hsptl_no: hospital.hsptl_no,
        doc_no: doctor.doc_no,
        doc_owner: 0,
        doc_price: 0,
        doc_price_phone: 0,
        doc_price_visit: 0,
        doc_publish: 0,
        doc_note: '',
      );
      var value = await DioHelper.postData(
          url: HOSPITAL_DOCTOR_ADD, data: doctorshospital.toJson());
      if (value.statusCode == 200) {
        if (value.data['status'] == 1) {
          return !hospital.isadded;
        }
      } else {
        showToast(
            text: value.statusCode.toString() + ' Error!',
            state: ToastStates.ERROR);
      }
    } catch (error) {
      ErrorHandler.handleError(error, showToast: true);
    }
    return hospital.isadded;
  }
}
