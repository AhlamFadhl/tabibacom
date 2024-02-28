import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabibacom_doctor/models/patient_model.dart';
import 'package:tabibacom_doctor/screens/add_patients/add_patients_page.dart';
import 'package:tabibacom_doctor/screens/list_patients/cubit/cubit.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_shadow.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class PatientDetailsPage extends StatelessWidget {
  PatientDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientsCubit, PatientsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = PatientsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('بيانات المريض'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: cubit.patientsDoctor == null
                ? CustomProgressIndicator()
                : CustomShadow(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                cubit.patientsDoctor!.ptn_name,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.to(AddPatientsPage(
                                      isEditing: true,
                                    ));
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          Divider(
                            color: Colors.grey.shade400,
                          ),
                          CustomSizedBox(
                            height: 10,
                          ),
                          CustomText(cubit.patientsDoctor!.ptn_phone),
                          CustomSizedBox(
                            height: 5,
                          ),
                          CustomText(((cubit.patientsDoctor!.ptn_email ?? '')
                                  .trim()
                                  .isEmpty)
                              ? 'لا يوجد بريد الإلكتروني'
                              : cubit.patientsDoctor!.ptn_email),
                          /*  CustomSizedBox(
                            height: 5,
                          ),
                          CustomText(
                              cubit.patientsDoctor!.ptn_gender == 0 ? '' : ''),
                          if (DateTime.parse(cubit.patientsDoctor!.ptn_birthday)
                                  .year >
                              0)
                            CustomText(DateFormat.yMMMd().format(DateTime.parse(
                                cubit.patientsDoctor!.ptn_birthday))),*/
                          CustomSizedBox(
                            height: 5,
                          ),
                          CustomText(cubit.patientsDoctor!.ptn_note == ''
                              ? 'لا يوجد ملاحظات'
                              : cubit.patientsDoctor!.ptn_note),
                          CustomSizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.grey.shade400,
                          ),
                          CustomSizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                radius: 30,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add,
                                      color: primaryColor,
                                    )),
                              ),
                              CustomSizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                radius: 30,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.phone,
                                      color: primaryColor,
                                    )),
                              ),
                              CustomSizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey.shade200,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.message,
                                      color: primaryColor,
                                    )),
                              ),
                              CustomSizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey.shade200,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.delete,
                                      color: primaryColor,
                                    )),
                              ),
                            ],
                          ),
                          CustomSizedBox(
                            height: 5,
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
