import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibacom_doctor/models/users_model.dart';
import 'package:tabibacom_doctor/screens/list_patients/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/signin/cubit/cubit.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/utils/error_handler.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

part 'state.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitial());
  static SplashCubit get(context) => BlocProvider.of(context);

  getUserData(isLogin, context) async {
    emit(SplashLoadingUserState());
    if (isLogin) {
      if (await checkInternet()) {
        try {
          await getUserSignIn();
          var value = await DioHelper.postData(
              url: USER_LOGIN,
              data: {'usr_phone': usrPhone, 'usr_pass': usrPass});
          print(value.data['status']);
          if (value.statusCode == 200) {
            if (value.data['status'] == 1) {
              SigninCubit.get(context).user =
                  Users.fromJson(value.data['user']);
              if (SigninCubit.get(context).user != null)
                user_doctor = SigninCubit.get(context).user!;

              emit(SplashSucessEnterUserState());
              PatientsCubit.get(context).list_patients_all =
                  user_doctor!.doctor!.patients ?? [];
            } else {
              emit(SplashFailedEnterUserState());
            }
          } else {
            emit(SplashNoInternetState());
          }
        } catch (error) {
          ErrorHandler.handleError(error, showToast: true);
          getUserData(isLogin, context);
          // emit(SplashErrorEnterUserState());
          print(error);
          //  showToast(text: 'حدث خطأ', state: ToastStates.ERROR);
        }
      } else {
        Future.delayed(Duration(seconds: 2)).then((value) {
          emit(SplashNoInternetState());
        });
      }
    } else {
      Future.delayed(Duration(seconds: 10)).then((value) {
        emit(SplashNotLoginState());
      });
    }
  }

  /////
}
