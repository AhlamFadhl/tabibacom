import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tabibacom_doctor/layout/home/home_layout.dart';
import 'package:tabibacom_doctor/models/category_model.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/users_model.dart';
import 'package:tabibacom_doctor/screens/category_list/category_list_page.dart';
import 'package:tabibacom_doctor/screens/signin/signin_page.dart';
import 'package:tabibacom_doctor/screens/signup/cubit/cubit.dart';
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

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit()..getAllCategory(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSucsses) {
            showToast(text: 'تم الدخول بنجاح', state: ToastStates.SUCCESS);
          } else if (state is SignUpFailed) {
            showToast(
                text: 'تأكد من معلومات الدخول', state: ToastStates.WARNING);
          } else if (state is SignUpError) {
            showToast(text: 'حدث خطأ اثناء لدخول', state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = SignUpCubit.get(context);
          return WillPopScope(
            onWillPop: () async {
              if (cubit.nextForm) {
                cubit.setNextForm(false);
                return false;
              } else
                return true;
            },
            child: Scaffold(
              //   backgroundColor: secondColor,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              imageDoctorComputer,
                              height: MediaQuery.of(context).size.height * 0.30,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    'تسجيل حساب',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          padding: EdgeInsets.all(10),
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: cubit.nextForm
                                                  ? Colors.grey.shade200
                                                  : secondColor,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(10),
                                              )),
                                          child: CustomText(
                                            'البيانات الآساسية',
                                            //  color: Colors.white,
                                            fontSize: 12,
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                        Container(
                                          width: 15,
                                          height: 40,
                                          child: CustomPaint(
                                            painter: TrianglePainter(
                                              strokeColor: cubit.nextForm
                                                  ? Colors.grey.shade200
                                                  : secondColor,
                                              strokeWidth: 2,
                                              paintingStyle: PaintingStyle.fill,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: !cubit.nextForm
                                                    ? Colors.grey.shade200
                                                    : secondColor,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                  topLeft: Radius.circular(0),
                                                  topRight: Radius.circular(0),
                                                )),
                                            child: CustomText(
                                              'المصادقه',
                                              fontSize: 12,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 15,
                                          height: 40,
                                          child: CustomPaint(
                                            painter: TrianglePainter(
                                              strokeColor: !cubit.nextForm
                                                  ? Colors.grey.shade200
                                                  : secondColor,
                                              strokeWidth: 2,
                                              paintingStyle: PaintingStyle.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (!cubit.nextForm)
                                    Form(
                                      key: cubit.formKey1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      'الاسم الأول',
                                                      fontSize: 13,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    CustomTextField(
                                                      controller:
                                                          cubit.controllerFName,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      validator: (val) =>
                                                          Validation
                                                              .firstnameValidate(
                                                                  val),
                                                      hintText:
                                                          'ادخل الاسم الأول',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              CustomSizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      'الاسم الأخير',
                                                      fontSize: 13,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    CustomTextField(
                                                      controller:
                                                          cubit.controllerLName,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      validator: (val) =>
                                                          Validation
                                                              .lastnameValidate(
                                                                  val),
                                                      hintText:
                                                          'ادخل الاسم الأخير',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          CustomText(
                                            'التخصص',
                                            fontSize: 13,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              CategoryDoc cat = await Get.to(
                                                  CategoryListPage(
                                                      list_category:
                                                          cubit.list_category));
                                              if (cat != null) {
                                                cubit.chooseCategoryDoc(cat);
                                              }
                                            },
                                            child: CustomBorder(
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 0,
                                                  top: 12),
                                              child: Container(
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          cubit.catDoctor ==
                                                                  null
                                                              ? 'اختر التخصص'
                                                              : cubit.catDoctor!
                                                                  .cat_name,
                                                          color:
                                                              cubit.catDoctor ==
                                                                      null
                                                                  ? Colors.grey
                                                                      .shade400
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                        Spacer(),
                                                        Icon(
                                                          Icons
                                                              .arrow_drop_down_sharp,
                                                          color: Colors
                                                              .grey.shade600,
                                                        )
                                                      ],
                                                    ),
                                                    CustomSizedBox(
                                                      height: 12,
                                                    ),
                                                    if (Validation.categoryValidate(
                                                                cubit
                                                                    .controllerCat
                                                                    .text) !=
                                                            null &&
                                                        cubit.isValidate)
                                                      CustomText(
                                                        Validation
                                                            .categoryValidate(
                                                                cubit
                                                                    .controllerCat
                                                                    .text),
                                                        color:
                                                            Colors.red.shade400,
                                                        fontSize: 12,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          CustomText(
                                            'البريد الإلكتروني',
                                            fontSize: 13,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomTextField(
                                            controller: cubit.controllerEmail,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: (value) =>
                                                Validation.emailValidate(value),
                                            hintText: 'ادخل البريد الإلكتروني',
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ////// Next
                                  if (cubit.nextForm)
                                    Form(
                                      key: cubit.formKey2,
                                      child: Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                'رقم الجوال',
                                                fontSize: 13,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CustomTextField(
                                                controller:
                                                    cubit.controllerPhone,
                                                keyboardType:
                                                    TextInputType.phone,
                                                validator: (val) =>
                                                    Validation.phoneValidate(
                                                        val),
                                                hintText: 'ادخل رقم الجوال',
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                'كلمة السر',
                                                fontSize: 13,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CustomTextField(
                                                controller:
                                                    cubit.controllerPass,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                validator: (val) =>
                                                    Validation.passwordValidate(
                                                        val),
                                                hintText: 'ادخل كلمة السر',
                                                obscureText: true,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  /////

                                  CustomButtonWidget(
                                    onTap: () {
                                      cubit.setValidate(true);
                                      if (!cubit.nextForm) {
                                        if (cubit.formKey1.currentState!
                                                .validate() &&
                                            cubit.catDoctor != null) {
                                          cubit.setNextForm(true);
                                        }
                                      } else {
                                        if (cubit.formKey2.currentState!
                                                .validate() &&
                                            cubit.catDoctor != null) {
                                          Users usr = Users(
                                              usr_no: 0,
                                              usr_name:
                                                  cubit.controllerFName.text,
                                              usr_phone:
                                                  cubit.controllerPhone.text,
                                              usr_pass:
                                                  cubit.controllerPass.text,
                                              usr_email:
                                                  cubit.controllerEmail.text,
                                              usr_stop: 0,
                                              usr_block: 0,
                                              usr_delete: 0,
                                              usr_type: 2,
                                              usr_google: 0,
                                              usr_doctor: 0,
                                              usr_hsptl: 0);
                                          Doctor doctor = Doctor(
                                              doc_no: 0,
                                              cat_no: cubit.catDoctor!.cat_no,
                                              doc_first_name:
                                                  cubit.controllerFName.text,
                                              doc_last_name:
                                                  cubit.controllerLName.text,
                                              doc_specialist: '',
                                              doc_image: '',
                                              doc_desc: '',
                                              doc_expirence: '',
                                              doc_images: '',
                                              doc_gender: 0,
                                              doc_date_joined:
                                                  DateTime.now().toString(),
                                              doc_license_img: '',
                                              doc_user: 0,
                                              doc_phone_exist: 0,
                                              doc_text_exist: 0,
                                              doc_birth_day:
                                                  DateTime.now().toString(),
                                              doc_naming: 0);
                                          /*  verifyPhoneNumber(
                                              cubit.controllerPhone.text);*/
                                          cubit.Register_User(
                                              usr, doctor, context);
                                        }
                                      }
                                    },
                                    loading: cubit.isLoading,
                                    icon: cubit.nextForm
                                        ? null
                                        : Icon(
                                            Icons
                                                .keyboard_double_arrow_left_sharp,
                                            size: 35,
                                          ),
                                    title: cubit.nextForm
                                        ? 'تسجيل حساب'
                                        : 'التالي',
                                  ),

                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        'لديك حساب في طبيبكم؟  ',
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          cubit.clearText();
                                          Get.off(SignInPage());
                                        },
                                        child: CustomText(
                                          'تسجيل دخول',
                                          fontSize: 12,
                                          color: primaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    phoneNumber = "+967" + phoneNumber;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieve verification code on Android devices.
        // This callback will be called when verification is done automatically.
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID to use later.
        // You can send this ID to your server if needed.
        print('Verification ID: $verificationId');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Called when the auto-retrieval timer expires.
        print('Timeout: $verificationId');
      },
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 2,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y / 2)
      ..lineTo(x, y)
      ..lineTo(x, 0)
      ..lineTo(0, y / 2);
    /*  ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);*/
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
