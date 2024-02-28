import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tabibacom_doctor/layout/home/home_layout.dart';
import 'package:tabibacom_doctor/screens/signin/signin_page.dart';
import 'package:tabibacom_doctor/screens/splash/cubit/cubit.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class SplashPage extends StatelessWidget {
  bool isLogin;
  SplashPage({required this.isLogin});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocProvider(
      create: (context) => SplashCubit()..getUserData(isLogin, context),
      child: BlocConsumer<SplashCubit, SplashStates>(
        listener: (context, state) {
          if (state is! SplashLoadingUserState &&
              state is! SplashNoInternetState) {
            if (state is SplashSucessEnterUserState) {
              Get.off(() => HomeLayout());
            } else /*if (state is SplashNotLoginState ||
                state is SplashFailedEnterUserState ||
                state is SplashErrorEnterUserState) */
            {
              Get.off(() => SignInPage());
            }
          }
        },
        builder: (context, state) {
          var cubit = SplashCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            body: Center(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/tabib_splash1.png'))),
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    if (state is SplashLoadingUserState)
                      Positioned(
                          bottom: MediaQuery.of(context).size.height * 0.33,
                          left: MediaQuery.of(context).size.width * 0.51,
                          child: CircularProgressIndicator()),
                    if (state is SplashNoInternetState)
                      Container(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              'لايوجد انترنت',
                              color: textErrorColor,
                            ),
                            MaterialButton(
                              onPressed: () {
                                cubit.getUserData(isLogin, context);
                              },
                              child: CustomText(
                                'حاول مرة اخرى',
                                color: primaryColor,
                                textDecoration: TextDecoration.lineThrough,
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
