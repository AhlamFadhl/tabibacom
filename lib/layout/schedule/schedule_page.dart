import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:tabibacom_doctor/layout/schedule/cubit/cubit.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/screens/list_book_history/list_book_history_page.dart';
import 'package:tabibacom_doctor/screens/list_book_next/list_book_next_page.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({required this.doctor, required this.hospital});
  Hospital hospital;
  Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleCubit(doctor: doctor, hospital: hospital)
        ..initalScrollController()
        ..getBookHistory(doctor.doc_no, hospital.hsptl_no)
        ..getBookNext(doctor.doc_no, hospital.hsptl_no, DateTime.now(),
            DateTime.now().add(const Duration(days: 60))),
      child: BlocConsumer<ScheduleCubit, ScheduleState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ScheduleCubit.get(context);
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Column(
                  children: [
                    Text('ملخص الحجوزات'),
                    CustomSizedBox(
                      height: 5,
                    ),
                    CustomText(
                      'في ' + hospital.hsptl_name,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  TabBar(labelColor: primaryColor, tabs: [
                    Tab(
                      text: 'القادمة',
                    ),
                    Tab(
                      text: 'السابقة',
                    ),
                  ]),
                  Expanded(
                      child: TabBarView(
                    children: [
                      ListBookNextPage(),
                      ListBookHistoryPage(),
                    ],
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
