import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:tabibacom_doctor/models/category_model.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/models/users_model.dart';
import 'package:tabibacom_doctor/screens/home/cubit/states.dart';
import 'package:tabibacom_doctor/screens/list_hospital/list_hospital_page.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeintialState());

  final _controller = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get stream1 => _controller.stream;

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Doctor> list_doctors = [];
  List<CategoryDoc> list_category = [];
  List<Hospital> list_hospital = [];
  getAllDoctors() {
    list_doctors = [];
    emit(HomeLoadingDoctorsState());
    DioHelper.postData(
      data: {},
      url: DOCTORS_GET_All,
    ).then((value) {
      print(value);
      List<dynamic> list = value.data;
      list_doctors = list.map((json) => Doctor.fromJson(json)).toList();
      emit(HomeGetDoctorsState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorGetDoctorsState());
    });
  }

  getAllCategory() {
    list_category = [];
    emit(HomeLoadingCategoryState());
    DioHelper.postData(
      data: {},
      url: CATEGORY_GET_ALL,
    ).then((value) {
      print(value);
      List<dynamic> list = value.data;
      list_category = list.map((json) => CategoryDoc.fromJson(json)).toList();
      emit(HomeGetCategoryState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorGetCategoryState());
    });
  }

  getAllHospital() {
    list_hospital = [];
    emit(HomeLoadingHospitalState());
    DioHelper.postData(
      data: {},
      url: HOSPITAL_GET_ALL,
    ).then((value) {
      print(value);
      List<dynamic> list = value.data;
      list_hospital = list.map((json) => Hospital.fromJson(json)).toList();
      emit(HomeGetHospitalState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorGetHospitalState());
    });
  }

  addHospitalOwner(Hospital hospital) {
    user_doctor!.doctor!.hospital_owner = hospital;
    emit(HomeChangeHospitalOwnerState());
  }

  setChange() {
    emit(HomeChangeState());
  }

  refresh_User() async {
    try {
      var value = await DioHelper.postData(
          url: USER_LOGIN,
          data: {'usr_phone': user_doctor!.usr_phone, 'usr_pass': usrPass});

      if (value.statusCode == 200) {
        print(value.data['status']);
        if (value.data['status'] == 1) {
          user_doctor = Users.fromJson(value.data['user']);
          emit(HomeChangeState());
          _controller.sink.add(SwipeRefreshState.hidden);
        }
      }
      _controller.sink.add(SwipeRefreshState.hidden);
    } catch (error) {
      _controller.sink.add(SwipeRefreshState.hidden);
    }
  }

  selectHospital() async {
    Hospital? hospital = await Get.to(ListHospitalPage());
    refresh_User();
  }
}
