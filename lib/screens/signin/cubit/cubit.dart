import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tabibacom_doctor/layout/home/home_layout.dart';
import 'package:tabibacom_doctor/models/users_model.dart';
import 'package:tabibacom_doctor/layout/home/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/list_patients/cubit/cubit.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/local/cache_helper.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

part 'states.dart';

class SigninCubit extends Cubit<SigninStates> {
  SigninCubit() : super(SigninInitial());
  static SigninCubit get(context) => BlocProvider.of(context);

  var controllerPhone = TextEditingController();
  var controllerPass = TextEditingController();

  clearText() {
    controllerPass.text = '';
    controllerPhone.text = '';
  }

  bool isLoading = false;
  var formKey = GlobalKey<FormState>();
  Users? user;
  final storage = FlutterSecureStorage();

  Login_User(String phone, String pass, context) async {
    isLoading = true;
    emit(SigninLoading());
    try {
      var value = await DioHelper.postData(
          url: USER_LOGIN, data: {'usr_phone': phone, 'usr_pass': pass});

      if (value.statusCode == 200) {
        print(value.data['status']);
        if (value.data['status'] == 1) {
          user = Users.fromJson(value.data['user']);
          user_doctor = user;
          isLoading = false;
          if (user != null) {
            usrNo = user!.usr_no;
            usrName = user!.usr_name;
            usrEmail = user!.usr_email ?? '';
            usrPass = pass;
            usrPhone = user!.usr_phone;

            saveUserSignIn();
            clearText();
            Get.offAll(HomeLayout());
            PatientsCubit.get(context).list_patients_all =
                user_doctor!.doctor!.patients ?? [];
          }
          emit(SigninSucsses());
        } else {
          isLoading = false;
          emit(SigninFailed());
        }
      } else {
        isLoading = false;
        emit(SigninFailed());
      }
    } catch (error) {
      isLoading = false;
      print(error);
      emit(SigninError());
    }
  }
}
