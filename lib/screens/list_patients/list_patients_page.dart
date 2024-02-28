import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:tabibacom_doctor/models/patient_model.dart';
import 'package:tabibacom_doctor/screens/add_patients/add_patients_page.dart';
import 'package:tabibacom_doctor/screens/list_patients/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/list_patients/patient_details_page.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_list_tile.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text_field.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class ListPatientsPage extends StatelessWidget {
  bool isBooking;
  bool isLoading = true;
  ListPatientsPage({super.key, this.isBooking = false});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientsCubit, PatientsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PatientsCubit.get(context);
        if (isLoading) {
          cubit.getPatientsDoctor(user_doctor!.doctor!.doc_no);
          isLoading = false;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'قائمة المرضى',
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: SwipeRefresh.material(
              stateStream: cubit.stream1,
              onRefresh: () {
                cubit.getPatientsDoctor(user_doctor!.doctor!.doc_no);
              },
              children: [
                CustomTextField(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'ابحث',
                  onChanged: (value) {
                    cubit.SearchPatients(value);
                  },
                ),
                CustomSizedBox(
                  height: 10,
                ),
                ConditionalBuilder(
                    condition: !cubit.list_patients.isEmpty,
                    fallback: (context) => ConditionalBuilder(
                        fallback: (context) => CustomProgressIndicator(),
                        condition: !cubit.isLoading,
                        builder: (context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.group_off_sharp,
                                  size: 50,
                                  color: textGrayColor,
                                ),
                                CustomText(
                                  'لا يوحد مرضى',
                                  color: textGrayColor,
                                ),
                              ],
                            ),
                          );
                        }),
                    builder: (context) {
                      return ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buidPatientItem(
                              cubit.list_patients[index], context),
                          separatorBuilder: (context, index) => Divider(
                                height: 1,
                              ),
                          itemCount: cubit.list_patients.length);
                    }),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(AddPatientsPage());
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  buidPatientItem(PatientsDoctor patientsDoctor, context) => Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InkWell(
            onTap: () {
              if (isBooking) {
                Get.back(result: patientsDoctor);
              } else {
                PatientsCubit.get(context).patientsDoctor = patientsDoctor;
                Get.to(PatientDetailsPage());
              }
            },
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    patientsDoctor.ptn_name,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomSizedBox(
                    height: 5,
                  ),
                  CustomText(
                    patientsDoctor.ptn_phone,
                    fontSize: 13,
                  ),
                  CustomSizedBox(
                    height: 5,
                  ),
                ],
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
        ]),
      );
}
