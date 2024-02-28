import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/screens/add_my_hospital/hospital_images_page.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/utils/error_handler.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart' as dio;
part 'states.dart';

class AddMyHospitalCubit extends Cubit<AddMyHospitalState> {
  AddMyHospitalCubit() : super(AddMyHospitalInitial());

  static AddMyHospitalCubit get(context) => BlocProvider.of(context);

  var ControllerName = TextEditingController();
  var ControllerNo = TextEditingController();
  var ControllerAddress = TextEditingController();
  var ControllerPrice = TextEditingController();
  bool isLoading = false;
  saveHospitalData(Hospital hsptl, {File? imageFile}) async {
    isLoading = true;
    Map<String, dynamic> h = hsptl.toJson();
    Map<String, dynamic> map = {};
    if (imageFile != null) {
      map = {
        "hsptl_logo": await dio.MultipartFile.fromFile(imageFile.path,
            filename: 'image.jpg'),
      };
      h.remove('hsptl_logo');
    }

    map.addAll(h);
    var formData = dio.FormData.fromMap(map);
    emit(AddMyHospitalSaving());
    DioHelper.postData(url: HOSPITAL_NEW, data: formData).then((value) async {
      if (value.data['status'] == 1) {
        Hospital? hospital;
        try {
          hospital = Hospital.fromJson(value.data['hospital']);
          showToast(text: 'تم اضافه عياده', state: ToastStates.SUCCESS);
          /*  Hospital? hospitalImages = await Get.to(HospitalImagesPage(
            hospital: hospital,
            isEditing: false,
          ));
          if (hospitalImages != null) {
            hospital = hospitalImages;
            Get.back(result: hospital);
          }*/
        } catch (e) {}
        isLoading = false;
        emit(AddMyHospitalSaved(hospital));
      } else if (value.data['status'] == -1) {
        showToast(text: 'اسم العياده موجود سابقاً', state: ToastStates.ERROR);
        isLoading = false;
        emit(AddMyHospitalFailed());
      } else {
        showToast(text: 'حدث خطأ !!', state: ToastStates.ERROR);
        isLoading = false;
        emit(AddMyHospitalFailed());
      }
    }).catchError((error) {
      isLoading = false;
      ErrorHandler.handleError(error, showToast: true);
      print(error);
      emit(AddMyHospitalError());
    });
  }

  setHospitalData(isEditing, Hospital? hospital) {
    if (isEditing && hospital != null) {
      ControllerName.text = hospital.hsptl_name;
      ControllerNo.text = hospital.hsptl_phone_call ?? '';
      ControllerAddress.text = hospital.hsptl_address ?? '';
      ControllerPrice.text = hospital.doc_price.toString();
    }
  }

  updateHospitalData(Hospital hsptl, {File? imageFile}) async {
    if (await checkInternet()) {
      isLoading = true;
      Map<String, dynamic> h = hsptl.toJson();
      Map<String, dynamic> map = {};
      if (imageFile != null) {
        map = {
          "hsptl_logo": await dio.MultipartFile.fromFile(imageFile.path,
              filename: 'image.jpg'),
        };
        h.remove('hsptl_logo');
      }

      map.addAll(h);
      var formData = dio.FormData.fromMap(map);

      ///Images////
      /*  formData.files.add(
        MapEntry(
          'images[]',
          await dio.MultipartFile.fromFile(imageFile!.path),
        ),
      );*/
      ////////////
      emit(AddMyHospitalSaving());
      DioHelper.postData(url: HOSPITAL_UPDATE, data: formData).then((value) {
        if (value.data['status'] == 1) {
          Hospital? hospital;
          try {
            hospital = Hospital.fromJson(value.data['hospital']);
          } catch (e) {}
          showToast(
              text: 'تم تعديل بيانات العياده', state: ToastStates.SUCCESS);
          isLoading = false;
          emit(AddMyHospitalUpdated(hospital));
        } else {
          isLoading = false;
          emit(AddMyHospitalFailedUpdate());
        }
      }).catchError((error) {
        print(error);
        isLoading = false;
        emit(AddMyHospitalErrorUpdate());
      });
    }
  }

  File? imageLogoHospital;
  changeFileLogo(File? file) {
    imageLogoHospital = file;
    emit(AddMyHospitalChangeFileLogo());
  }

  Future<int> updateImageLogoHospital(File imageFile, Hospital hospital) async {
    var formData = dio.FormData.fromMap({
      "hsptl_logo": await dio.MultipartFile.fromFile(imageFile.path,
          filename: 'image.jpg'),
      "hsptl_no": hospital.hsptl_no,
    });

    try {
      var value =
          await DioHelper.postData(url: HOSPITAL_UPDATE_LOGO, data: formData);
      if (value.data['status'] == 1) {
        hospital.hsptl_logo = value.data['url'];
        emit(AddMyHospitalUpdatedLogo(hospital.hsptl_logo));
      } else
        emit(AddMyHospitalUpdatedLogoFailed());
      return value.data['status'];
    } catch (e) {
      print(e);
      emit(AddMyHospitalUpdatedLogoError());
    }

    return 0;
  }
}
