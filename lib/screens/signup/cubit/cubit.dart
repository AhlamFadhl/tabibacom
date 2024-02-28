import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tabibacom_doctor/layout/home/home_layout.dart';
import 'package:tabibacom_doctor/models/category_model.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/users_model.dart';
import 'package:tabibacom_doctor/screens/list_patients/cubit/cubit.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/utils/error_handler.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

part 'state.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);
  bool isLoading = false;
  bool nextForm = false;
  bool isValidate = false;
  var formKey1 = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  var controllerFName = TextEditingController();
  var controllerLName = TextEditingController();
  var controllerPhone = TextEditingController();
  var controllerPass = TextEditingController();
  var controllerEmail = TextEditingController();
  var controllerCat = TextEditingController();

  clearText() {
    controllerCat.text = '';
    controllerEmail.text = '';
    controllerFName.text = '';
    controllerLName.text = '';
    controllerPass.text = '';
    controllerPhone.text = '';
  }

  CategoryDoc? catDoctor;
  setNextForm(value) async {
    if (value) {
      isLoading = true;
      emit(SignUpLoading());
      try {
        var response = await DioHelper.postData(
            url: 'user/check/email', data: {'usr_email': controllerEmail.text});
        if (response.statusCode == 200) {
          if (response.data['status'] == 1) {
            isLoading = false;
            nextForm = value;
            emit(SignUpNextState());
          } else {
            isLoading = false;
            emit(SignUpFailedNextState());
            showToast(
                text: 'هذا البريد الالكتروني غير متاح',
                state: ToastStates.ERROR);
          }
        } else {
          isLoading = false;
          emit(SignUpFailedNextState());
        }
      } catch (e) {
        ErrorHandler.handleError(e, showToast: true);
        isLoading = false;
        emit(SignUpFailedNextState());
        showToast(text: 'حدث خطأ !', state: ToastStates.ERROR);
      }
    } else {
      nextForm = value;
      emit(SignUpNextState());
    }
  }

  setValidate(value) {
    isValidate = value;
    emit(SignUpNextState());
  }

  Register_User(Users usr, Doctor doc, context) {
    isLoading = true;
    emit(SignUpLoading());
    DioHelper.postData(url: USER_NEW, data: {
      'user': usr.toJson(),
      'doctor': doc.toJson(),
    }).then((value) {
      if (value.statusCode == 200) {
        print(value.data['status']);
        if (value.data['status'] == 1) {
          Users user = Users.fromJson(value.data['user']);
          user_doctor = user;
          isLoading = false;
          if (user != null) {
            usrNo = user.usr_no;
            usrName = user.usr_name;
            usrEmail = user.usr_email ?? '';
            usrPass = usr.usr_pass;
            usrPhone = usr.usr_phone;

            saveUserSignIn();
            clearText();
            Get.offAll(HomeLayout());
            PatientsCubit.get(context).list_patients_all =
                user_doctor!.doctor!.patients ?? [];
          }
          isLoading = false;
          emit(SignUpSucsses());
        } else if (value.data['status'] == -1) {
          showToast(text: 'رقم الجوال غير متاح', state: ToastStates.ERROR);
          isLoading = false;
          emit(SignUpPhoneFailed());
        } else if (value.data['status'] == -2) {
          showToast(
              text: 'البريد الألكتروني غير متاح', state: ToastStates.ERROR);
          isLoading = false;
          emit(SignUpEmailFailed());
        } else {
          isLoading = false;
          emit(SignUpFailed());
        }
      } else {
        isLoading = false;
        emit(SignUpFailed());
      }
    }).catchError((error) {
      print(error);
      isLoading = false;
      emit(SignUpError());
    });
  }

  chooseCategoryDoc(cat) {
    if (cat != null) {
      catDoctor = cat;
      controllerCat.text = catDoctor!.cat_name;
      emit(SignUpSelectCatState());
    }
  }

  ////////
  List<CategoryDoc> list_category = [];
  getAllCategory() {
    list_category = [];
    emit(SignUpLoadingCategoryState());
    DioHelper.postData(
      data: {},
      url: CATEGORY_GET_ALL,
    ).then((value) {
      print(value);
      List<dynamic> list = value.data;
      list_category = list.map((json) => CategoryDoc.fromJson(json)).toList();
      emit(SignUpGetCategoryState());
    }).catchError((error) {
      print(error.toString());
      emit(SignUpErrorGetCategoryState());
    });
  }
}
