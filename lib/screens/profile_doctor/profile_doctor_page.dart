import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/screens/profile_doctor/add_image_page.dart';
import 'package:tabibacom_doctor/screens/profile_doctor/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/profile_doctor/subcategories_list_page.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_image.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text_field.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/components/utils/validation.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';

class ProfileDoctor extends StatelessWidget {
  ProfileDoctor({required this.doctor});
  Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileDoctorCubit, ProfileDoctorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProfileDoctorCubit.get(context)..doctor = doctor;
        return Scaffold(
          appBar: AppBar(
            title: Text('بيانات الطبيب'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ///////
                Center(
                    child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100, shape: BoxShape.circle),
                      child: cubit.imageDoctorFile == null
                          ? CustomImage(
                              url: cubit.doctor == null
                                  ? ''
                                  : PATH_IMAGES + cubit.doctor!.doc_image,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              cubit.imageDoctorFile!,
                              fit: BoxFit.cover,
                            ),
                    ),
                    //  if (isEditing)
                    IconButton(
                      onPressed: () async {
                        cubit.setFileImageProfile(await pickImage(context));
                        if (cubit.imageDoctorFile != null) {
                          cubit.updateImageDoctor(cubit.imageDoctorFile!);
                        }
                      },
                      icon: CircleAvatar(
                        child: Icon(
                          Icons.add_a_photo_outlined,
                        ),
                      ),
                    )
                  ],
                )),
                ///////
                buildCardInformationWedgit(
                    'التخصص الاساسي', CustomText(cubit.doctor!.cat_name),
                    onPressed: () {
                  Get.snackbar(
                      '', 'لايمكن تغيير تخصصك الاساسي تواصل مع خدمه العملاء',
                      snackPosition: SnackPosition.BOTTOM);
                }),
                SizedBox(
                  height: 8,
                ),
                buildCardInformationWedgit(
                    'التخصصات الفرعية',
                    cubit.doctor!.subcatogries == null
                        ? CustomText('')
                        : Wrap(
                            children: List.generate(
                                cubit.doctor!.subcatogries!.length,
                                (index) => Wrap(
                                      children: [
                                        if (cubit.doctor!.subcatogries![index]
                                            .selected)
                                          CustomText(
                                            cubit.doctor!.subcatogries![index]
                                                    .sub_title +
                                                ' / ',
                                            fontSize: 12,
                                          ),
                                      ],
                                    )),
                          ), onPressed: () async {
                  if (cubit.doctor!.subcatogries != null) {
                    cubit.subcategories = cubit.doctor!.subcatogries!;
                    Get.to(SubCategoriesListPage());
                  }
                }),
                SizedBox(
                  height: 8,
                ),
                buildCardInformationWedgit(
                    'اسم الطبيب',
                    CustomText(
                      cubit.doctor!.doc_first_name +
                          ' ' +
                          cubit.doctor!.doc_last_name,
                    ), onPressed: () async {
                  _showPopupName(context, cubit.doctor!);
                }),
                SizedBox(
                  height: 8,
                ),
                /*  buildCardInformation(
                  'لقب الطبيب',
                  cubit.doctor.doc_naming.toString(),
                  onPressed: () {},
                ),
                SizedBox(
                  height: 8,
                ),*/
                buildCardInformationWedgit(
                  'نيذه عن الطبيب',
                  CustomText(cubit.doctor!.doc_desc),
                  onPressed: () {
                    _showPopupDesc(context, cubit.doctor!);
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                buildCardInformationWedgit(
                  'النوع',
                  CustomText(cubit.doctor!.doc_gender == 0 ? 'ذكر' : 'انثى'),
                  onPressed: () {
                    _showPopupGender(context, cubit.doctor!);
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                buildCardInformationWedgit(
                  'تاريخ الميلاد',
                  CustomText(
                    DateFormat.yMMMMd().format(
                        DateTime.tryParse(cubit.doctor!.doc_birth_day) ??
                            DateTime.now()),
                  ),
                  onPressed: () {
                    cubit.selectDate(context,
                        DateTime.tryParse(cubit.doctor!.doc_birth_day));
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                buildCardInformationImage(
                  'رخصه مزاولة مهنة',
                  PATH_IMAGES + cubit.doctor!.doc_license_img.toString(),
                  onPressed: () {
                    Get.to(AddImagePage())!
                        .then((value) => cubit.imageLicenceFile = null);
                  },
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPopupName(BuildContext context, Doctor doc) {
    var controllerFirstName = TextEditingController(text: doc.doc_first_name);
    var controllerLastName = TextEditingController(text: doc.doc_last_name);
    var formKey = GlobalKey<FormState>();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: Text('اسم الطبيب'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: controllerFirstName,
                  hintText: 'الاسم الاول',
                  validator: (value) => Validation.firstnameValidate(value),
                ),
                CustomSizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: controllerLastName,
                  hintText: 'الاسم الاخير',
                  validator: (value) => Validation.lastnameValidate(value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('اغلاق'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if (await checkInternet()) {
                    ProgressDialog prg = customProgressDialog(context);
                    prg.show();
                    var value = await ProfileDoctorCubit.get(context)
                        .updateNameDoctor(
                            controllerFirstName.text, controllerLastName.text);
                    prg.hide();
                    if (value == 1) {
                      Navigator.of(context).pop();
                      showToast(text: 'تم الحفظ', state: ToastStates.SUCCESS);
                    } else
                      showToast(
                          text: 'حدث خطأ اثناء الحفظ',
                          state: ToastStates.ERROR);
                  }
                }
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  void _showPopupDesc(BuildContext context, Doctor doc) {
    var controllerDesc = TextEditingController(text: doc.doc_desc);
    var formKey = GlobalKey<FormState>();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: Text('نبذه عن الطبيب'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: controllerDesc,
                  hintText: 'وصف',
                  maxLines: 10,
                  validator: (value) => Validation.descrptionValidate(value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('اغلاق'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if (await checkInternet()) {
                    ProgressDialog prg = customProgressDialog(context);
                    prg.show();
                    var value = await ProfileDoctorCubit.get(context)
                        .updateDescDoctor(controllerDesc.text);
                    prg.hide();
                    if (value == 1) {
                      Navigator.of(context).pop();
                      showToast(text: 'تم الحفظ', state: ToastStates.SUCCESS);
                    } else
                      showToast(
                          text: 'حدث خطأ اثناء الحفظ',
                          state: ToastStates.ERROR);
                  }
                }
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  void _showPopupGender(BuildContext context, Doctor doc) {
    var controllerDesc = TextEditingController(text: doc.doc_desc);
    var formKey = GlobalKey<FormState>();
    ProfileDoctorCubit.get(context).setChangeGender(doc.doc_gender);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<ProfileDoctorCubit, ProfileDoctorStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = ProfileDoctorCubit.get(context);
            return AlertDialog(
              title: Text('النوع'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('ذكر'),
                    leading: Radio(
                      value: 0,
                      groupValue: cubit.select_gender,
                      onChanged: (value) {
                        cubit.setChangeGender(value);
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('أنِثى'),
                    leading: Radio(
                      value: 1,
                      groupValue: cubit.select_gender,
                      onChanged: (value) {
                        cubit.setChangeGender(value);
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('اغلاق'),
                ),
                TextButton(
                  onPressed: () async {
                    if (await checkInternet()) {
                      ProgressDialog prg = customProgressDialog(context);
                      prg.show();
                      var value =
                          await cubit.updateGenderDoctor(cubit.select_gender);
                      prg.hide();
                      if (value == 1) {
                        Navigator.of(context).pop();
                        showToast(text: 'تم الحفظ', state: ToastStates.SUCCESS);
                      } else {
                        showToast(
                            text: 'حدث خطأ اثناء الحفظ',
                            state: ToastStates.ERROR);
                      }
                    }
                  },
                  child: Text('حفظ'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
