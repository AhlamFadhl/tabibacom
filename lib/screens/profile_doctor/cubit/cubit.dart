import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/sub_categories.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

part 'states.dart';

class ProfileDoctorCubit extends Cubit<ProfileDoctorStates> {
  ProfileDoctorCubit({this.doctor}) : super(ProfileDoctorInitial());

  static ProfileDoctorCubit get(context) => BlocProvider.of(context);

  Doctor? doctor;

  Future<int> updateNameDoctor(first_name, last_name) async {
    try {
      var value = await DioHelper.postData(url: DOCTOR_UPDATE_NAME, data: {
        'doc_first_name': first_name,
        'doc_last_name': last_name,
        'doc_doc': doctor!.doc_no,
      });

      if (value.data['status'] == 1) {
        doctor!.doc_first_name = first_name;
        doctor!.doc_last_name = last_name;
        emit(ProfileDoctorSaved());
      } else
        emit(ProfileDoctorFailed());
      return value.data['status'];
    } catch (e) {
      print(e);
      emit(ProfileDoctorError());
    }

    return 0;
  }

  Future<int> updateDescDoctor(desc) async {
    try {
      var value = await DioHelper.postData(url: DOCTOR_UPDATE_DESC, data: {
        'doc_desc': desc,
        'doc_doc': doctor!.doc_no,
      });
      if (value.data['status'] == 1) {
        doctor!.doc_desc = desc;
        emit(ProfileDoctorSaved());
      } else
        emit(ProfileDoctorFailed());
      return value.data['status'];
    } catch (e) {
      print(e);
      emit(ProfileDoctorError());
    }

    return 0;
  }

  int select_gender = 0;
  setChangeGender(vale) {
    select_gender = vale;
    emit(ProfileDoctorChangeGenderState());
  }

  Future<int> updateGenderDoctor(gender) async {
    try {
      var value = await DioHelper.postData(url: DOCTOR_UPDATE_GENDER, data: {
        'doc_gender': gender,
        'doc_doc': doctor!.doc_no,
      });
      if (value.data['status'] == 1) {
        doctor!.doc_gender = gender;
        emit(ProfileDoctorSaved());
      } else
        emit(ProfileDoctorFailed());
      return value.data['status'];
    } catch (e) {
      print(e);
      emit(ProfileDoctorError());
    }

    return 0;
  }

  File? imageLicenceFile;
  setFileImageLicence(file) {
    imageLicenceFile = file;
    emit(ProfileDoctorSetFileImageState());
  }

  File? imageDoctorFile;
  setFileImageProfile(file) {
    imageDoctorFile = file;
    emit(ProfileDoctorSetFileImageState());
  }

  Future<int> updateImageDoctor(File imageFile) async {
    var formData = dio.FormData.fromMap({
      "doc_image": await dio.MultipartFile.fromFile(imageFile.path,
          filename: 'image.jpg'),
      "doc_doc": doctor!.doc_no,
    });

    try {
      var value =
          await DioHelper.postData(url: DOCTOR_UPDATE_IMAGE, data: formData);
      if (value.data['status'] == 1) {
        imageDoctorFile = null;
        doctor!.doc_image = value.data['url'];
        user_doctor!.doctor!.doc_image = value.data['url'];
        emit(ProfileDoctorSaved());
      } else
        emit(ProfileDoctorFailed());
      return value.data['status'];
    } catch (e) {
      imageDoctorFile = null;
      print(e);
      emit(ProfileDoctorError());
    }

    return 0;
  }

  Future<int> updateImageLiceneDoctor(File imageFile) async {
    var formData = dio.FormData.fromMap({
      "doc_license_img": await dio.MultipartFile.fromFile(imageFile.path,
          filename: 'image.jpg'), //imageFile.path.split('/').last
      "doc_doc": doctor!.doc_no,
    });

    // List<int> imageBytes = imageFile.readAsBytesSync();
    //String imageString = base64Encode(imageBytes);

    try {
      var value = await DioHelper.postData(
          url: DOCTOR_UPDATE_LICENCIMG, data: formData);
      if (value.data['status'] == 1) {
        doctor!.doc_license_img = value.data['url'];
        emit(ProfileDoctorSaved());
      } else
        emit(ProfileDoctorFailed());
      return value.data['status'];
    } catch (e) {
      print(e);
      emit(ProfileDoctorError());
    }

    return 0;
  }

  DateTime? bith_date;
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
      if (await checkInternet()) {
        bith_date = picked;
        ProgressDialog prg = customProgressDialog(context);
        prg.show();
        var value = await updateGenderBirthDay(bith_date);
        if (value == 1) {
          showToast(text: 'تم الحفظ', state: ToastStates.SUCCESS);
        } else
          showToast(text: 'حدث خطأ لم يتم الحفظ', state: ToastStates.ERROR);
        prg.hide();
      }
    }
  }

  Future<int> updateGenderBirthDay(date) async {
    try {
      var value = await DioHelper.postData(url: DOCTOR_UPDATE_BIRTHDAY, data: {
        'doc_birth_day': DateFormat('yyyy-MM-dd').format(date),
        'doc_doc': doctor!.doc_no,
      });
      if (value.data['status'] == 1) {
        doctor!.doc_birth_day = date.toString();
        emit(ProfileDoctorSaved());
      } else
        emit(ProfileDoctorFailed());
      return value.data['status'];
    } catch (e) {
      print(e);
      emit(ProfileDoctorError());
    }

    return 0;
  }

  List<SubCategories> subcategories = [];
  selectnuselectSubcategory(index) async {
    if (await checkInternet()) {
      subcategories[index].selected = !subcategories[index].selected;
      emit(ProfileDoctorSelectedSubCatState());
      DioHelper.postData(
              url: DOCTOR_UPDATE_SUBCATEGORY,
              data: subcategories[index].toJson())
          .then((value) {
        if (value.data['status'] == 1) {
          emit(ProfileDoctorSaved());
        } else {
          subcategories[index].selected = !subcategories[index].selected;
          showToast(
              text: ' حدث خطأ اثناء حفظ التخصص الفرعي' +
                  subcategories[index].sub_title,
              state: ToastStates.ERROR);
          emit(ProfileDoctorFailed());
        }
      }).catchError((error) {
        print(error);
        subcategories[index].selected = !subcategories[index].selected;
        showToast(text: error.toString(), state: ToastStates.ERROR);
        subcategories[index].selected = !subcategories[index].selected;
        emit(ProfileDoctorError());
      });
    }
  }
}
