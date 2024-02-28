import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tabibacom_doctor/layout/home/home_layout.dart';
import 'package:tabibacom_doctor/screens/home/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/profile_doctor/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/list_patients/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/signin/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/splash/splash_page.dart';
import 'package:tabibacom_doctor/shared/bloc_observer.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/layout/home/cubit/cubit.dart';
import 'package:tabibacom_doctor/layout/home/cubit/states.dart';
import 'package:tabibacom_doctor/shared/network/local/cache_helper.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';
import 'package:tabibacom_doctor/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (_) {}
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await DioHelper.init();
  bool isLogin =
      (await CacheHelper.getData(key: KeyUserNo) ?? 0) == 0 ? false : true;
  runApp(MyApp(
    isLogin: isLogin,
  ));
}

class MyApp extends StatelessWidget {
  bool isLogin;
  MyApp({required this.isLogin});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SigninCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileDoctorCubit(),
        ),
        BlocProvider(
          create: (context) => PatientsCubit(),
        ),
      ],
      child: BlocConsumer<SigninCubit, SigninStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            builder: (context, child) => GetMaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              locale: const Locale('ar'),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('ar', 'YE'), // Arabic
                Locale('en', 'US'), // English
              ],
              home: SplashPage(
                isLogin: isLogin,
              ),
            ),
          );
        },
      ),
    );
  }
}
