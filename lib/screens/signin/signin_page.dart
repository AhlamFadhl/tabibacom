import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tabibacom_doctor/layout/home/home_layout.dart';
import 'package:tabibacom_doctor/screens/signin/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/signup/signup_page.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_border.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_button_widget.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_shadow.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text_field.dart';
import 'package:tabibacom_doctor/shared/components/images.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/components/utils/validation.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninStates>(
      listener: (context, state) {
        if (state is SigninSucsses) {
          showToast(text: 'تم الدخول بنجاح', state: ToastStates.SUCCESS);
        } else if (state is SigninFailed) {
          showToast(text: 'تأكد من معلومات الدخول', state: ToastStates.WARNING);
        } else if (state is SigninError) {
          showToast(text: 'حدث خطأ اثناء لدخول', state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = SigninCubit.get(context);
        return Scaffold(
          //   backgroundColor: secondColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          imageDoctors,
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: double.infinity,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Center(
                            child: Image.asset(
                              iconLogo,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: CustomShadow(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: cubit.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  'مرحباً بك في طبيبكم ...',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomSizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      'رقم الجوال',
                                      fontSize: 13,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomTextField(
                                      controller: cubit.controllerPhone,
                                      keyboardType: TextInputType.phone,
                                      validator: (value) =>
                                          Validation.phoneValidate(value),
                                      hintText: 'ادخل رقم الجوال',
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      'كلمة السر',
                                      fontSize: 13,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomTextField(
                                      controller: cubit.controllerPass,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: (value) =>
                                          Validation.passwordValidate(value),
                                      hintText: 'ادخل كلمة السر',
                                      obscureText: true,
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: CustomText(
                                          'هل نسيت كلمة السر؟',
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          textDecoration:
                                              TextDecoration.underline,
                                          color: primaryColor,
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                CustomButtonWidget(
                                    loading: cubit.isLoading,
                                    onTap: () {
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        cubit.Login_User(
                                            cubit.controllerPhone.text,
                                            cubit.controllerPass.text,
                                            context);
                                      }
                                    },
                                    title: 'دخول'),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      'ليس لديك حساب في طبيبكم؟  ',
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        cubit.clearText();
                                        Get.off(SignupPage());
                                      },
                                      child: CustomText(
                                        'أنشئ حساب الأن',
                                        fontSize: 12,
                                        color: primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                /* TextButton(
                                  onPressed: () {
                                    Get.to(
                                      () => SignupPage(),
                                    );
                                  },
                                  child: Text(
                                    'تسجيل حساب جديد',
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> signInWithPhoneNumber(
      String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      print('Phone number verified successfully.');
    } catch (e) {
      print('Failed to verify phone number: $e');
    }
  }
}
