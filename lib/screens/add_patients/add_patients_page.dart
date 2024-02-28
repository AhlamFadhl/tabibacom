import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tabibacom_doctor/models/patient_model.dart';
import 'package:tabibacom_doctor/models/type_model.dart';
import 'package:tabibacom_doctor/screens/list_patients/cubit/cubit.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text_field.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/components/utils/validation.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class AddPatientsPage extends StatelessWidget {
  bool isBooking;
  bool isEditing;
  AddPatientsPage({super.key, this.isBooking = false, this.isEditing = false});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientsCubit, PatientsState>(
      listener: (context, state) {
        if (state is PatientsSavedState) {
          Get.back();
        } else if (state is PatientsErrorSaveState) {
          showToast(text: 'حدث خطأ اثناء الحفظ', state: ToastStates.ERROR);
        } else if (state is PatientsFailedSaveState) {
          showToast(text: 'رقم المريض موجود من قبل', state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = PatientsCubit.get(context)..setDataToEdit();
        return Scaffold(
          appBar: AppBar(
            title: Text('بيانات المريض'),
            actions: [
              IconButton(
                onPressed: () {
                  if (state is PatientsSavingState) {
                    showToast(
                        text: 'الرجاء الأنتظار ..', state: ToastStates.WARNING);
                    return;
                  }
                  PatientsDoctor ptnt = PatientsDoctor(
                    ptn_no: 0,
                    ptn_birthday: cubit.controller_date.text,
                    ptn_name: cubit.controller_name.text,
                    ptn_phone: cubit.controller_no.text,
                    doc_no: user_doctor!.doctor!.doc_no,
                    ptn_email: cubit.controller_email.text,
                    ptn_idcard: cubit.controller_idcard.text,
                    ptn_typecard: cubit.dropdownValueType.type_id,
                    ptn_gender: cubit.select_gender,
                    ptn_note: cubit.controller_note.text,
                    ptn_user: user_doctor!.usr_no,
                  );
                  cubit.inserttPatientsDoctor(ptnt);
                },
                icon: (state is PatientsSavingState)
                    ? CustomProgressIndicator()
                    : Icon(Icons.save),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText('اسم المريض'),
                        CustomText(
                          '*',
                          color: textErrorColor,
                        ),
                      ],
                    ),
                    CustomSizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      hintText: 'اسم المريض',
                      controller: cubit.controller_name,
                      validator: (value) =>
                          Validation.patientnameValidate(value),
                    ),
                    CustomSizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        CustomText('رقم المريض'),
                        CustomText(
                          '*',
                          color: textErrorColor,
                        ),
                      ],
                    ),
                    CustomSizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      hintText: 'رقم المريض',
                      controller: cubit.controller_no,
                      keyboardType: TextInputType.number,
                      validator: (value) => Validation.patientnoValidate(value),
                    ),
                    CustomSizedBox(
                      height: 15,
                    ),
                    CustomText('البريد الإلكتروني'),
                    CustomSizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      hintText: 'البريد الإلكتروني',
                      controller: cubit.controller_email,
                    ),
                    CustomSizedBox(
                      height: 15,
                    ),
                    CustomText('جنس المريض'),
                    CustomSizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.setChangeGender(0);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Radio(
                                    value: 0,
                                    groupValue: cubit.select_gender,
                                    onChanged: (value) {
                                      cubit.setChangeGender(value);
                                    },
                                  ),
                                ),
                                CustomText(
                                  'ذكر',
                                ),
                              ],
                            ),
                          ),
                          CustomSizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              cubit.setChangeGender(1);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Radio(
                                    value: 1,
                                    groupValue: cubit.select_gender,
                                    onChanged: (value) {
                                      cubit.setChangeGender(value);
                                    },
                                  ),
                                ),
                                CustomText(
                                  'أنِثى',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSizedBox(
                      height: 15,
                    ),
                    CustomText('تاريخ الميلاد'),
                    CustomSizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        cubit.selectDate(context, DateTime.now());
                      },
                      child: CustomTextField(
                        hintText: 'تاريخ الميلاد',
                        controller: cubit.controller_date,
                        enabled: false,
                      ),
                    ),
                    CustomSizedBox(
                      height: 15,
                    ),
                    CustomText('نوع الهويه'),
                    CustomSizedBox(
                      height: 5,
                    ),
                    DropdownButton<TypeModel>(
                      isExpanded: true,
                      value: cubit.dropdownValueType,
                      items: list_type_card
                          .map<DropdownMenuItem<TypeModel>>((TypeModel value) {
                        return DropdownMenuItem<TypeModel>(
                          value: value,
                          child: Text(
                            value.type_name,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (TypeModel? newValue) {
                        cubit.changeCard_type(newValue);
                      },
                    ),
                    CustomSizedBox(
                      height: 15,
                    ),
                    CustomText('رقم الهويه'),
                    CustomSizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      hintText: 'رقم الهويه',
                      controller: cubit.controller_idcard,
                      keyboardType: TextInputType.number,
                    ),
                    CustomSizedBox(
                      height: 15,
                    ),
                    CustomText('ملاحظات'),
                    CustomSizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      hintText: 'ملاحظات',
                      controller: cubit.controller_note,
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
}
