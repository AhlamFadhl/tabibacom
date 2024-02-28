import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:tabibacom_doctor/layout/home/cubit/states.dart';
import 'package:tabibacom_doctor/models/book_model.dart';
import 'package:tabibacom_doctor/models/dates_book_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/screens/add_book/add_book_page.dart';
import 'package:tabibacom_doctor/screens/my_appointments/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/my_appointments/hospital_details_page.dart';
import 'package:tabibacom_doctor/screens/signin/signin_page.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/layout/home/cubit/cubit.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_border.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_shadow.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';
import 'package:tabibacom_doctor/shared/styles/styles.dart';
import 'package:table_calendar/table_calendar.dart';

class MyAppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAppointmentsCubit()
        /*     ..getBookAppoientmens(
            user_doctor!.doctor!.doc_no, DateTime.now(), DateTime.now())*/
        ..getHospitalDataToday(DateTime.now(), user_doctor!.doctor!.doc_no),
      child: BlocConsumer<MyAppointmentsCubit, MyAppointmentsStatess>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MyAppointmentsCubit.get(context);
          return ConditionalBuilder(
            condition: state is AppLoadingMyAppoientmentsState,
            builder: (context) {
              return CircularProgressIndicator();
            },
            fallback: (context) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: SwipeRefresh.material(
                  stateStream: cubit.stream1,
                  onRefresh: () {
                    cubit.getHospitalDataToday(
                        DateTime.now(), user_doctor!.doctor!.doc_no);
                  },
                  //  mainAxisSize: MainAxisSize.max,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Hopital Information

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              bottom: 15, start: 10),
                          child: CustomText(
                            'حجوزات اليوم',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            cubit.changeStyleShowList(1);
                          },
                          child: CustomShadow(
                            color: cubit.typeStyle == 1
                                ? secondColor.withOpacity(0.5)
                                : null,
                            raduis: 10,
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              child: Icon(Icons.list_sharp),
                            ),
                          ),
                        ),
                        CustomSizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            cubit.changeStyleShowList(2);
                          },
                          child: CustomShadow(
                            raduis: 10,
                            color: cubit.typeStyle == 2
                                ? secondColor.withOpacity(0.5)
                                : null,
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              child: Icon(Icons.grid_view),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomSizedBox(
                      height: 10,
                    ),
                    CustomBorder(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          CustomShadow(
                              child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.date_range_outlined,
                              color: insideColor,
                            ),
                          )),
                          CustomSizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                DateFormat('EEEE', 'ar').format(DateTime.now()),
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomSizedBox(
                                height: 5,
                              ),
                              CustomText(
                                  DateFormat.yMMMEd().format(DateTime.now())),
                            ],
                          ),
                          Spacer(),
                          if (cubit.hospital_today.isNotEmpty)
                            InkWell(
                              onTap: () async {
                                if (cubit.hospital_today.length > 1) {
                                  showBottomSheetHospitals(
                                      cubit.hospital_today, context);
                                } else {
                                  int? status = await Get.to(AddBookPage(
                                      selectDate: DateTime.now(),
                                      doctor: user_doctor!.doctor!,
                                      hospital: cubit.hospital_today[0]));

                                  if (status != null && status == 1) {
                                    cubit.getHospitalDataToday(
                                      DateTime.now(),
                                      user_doctor!.doctor!.doc_no,
                                    );
                                  }
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: primaryColor,
                                child: Container(
                                    height: 37,
                                    width: 37,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: primaryColor,
                                    )),
                              ),
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: cubit.isLoading
                          ? CustomProgressIndicator()
                          : ConditionalBuilder(
                              fallback: (context) => Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: Center(
                                      child: CustomText(
                                        'لا يوجد دوام في هذا اليوم',
                                        color: textGrayColor,
                                      ),
                                    ),
                                  ),
                              condition: cubit.hospital_today.isNotEmpty,
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Row(
                                                  children: [
                                                    cubit
                                                                .hospital_today[
                                                                    index]
                                                                .appointments[0]
                                                                .apnt_avalible ==
                                                            1
                                                        ? Row(
                                                            children: [
                                                              CustomText(DateFormat.jm().format(DateTime.parse("2023-01-01 " +
                                                                  cubit
                                                                      .hospital_today[
                                                                          index]
                                                                      .appointments[
                                                                          0]
                                                                      .apnt_from_time))),
                                                              CustomText(' - '),
                                                              CustomText(DateFormat.jm().format(DateTime.parse("2023-01-01 " +
                                                                  cubit
                                                                      .hospital_today[
                                                                          index]
                                                                      .appointments[
                                                                          0]
                                                                      .apnt_to_time))),
                                                            ],
                                                          )
                                                        : Container(
                                                            child: CustomText(
                                                                'غير متاح'),
                                                          ),
                                                    Spacer(),
                                                    buidCardHospital(cubit
                                                        .hospital_today[index]),
                                                  ],
                                                ),
                                              ),
                                              CustomSizedBox(
                                                height: 10,
                                              ),
                                              HospitalDetailsAppointmentsPage(
                                                hospital_today:
                                                    cubit.hospital_today[index],
                                                typeStyle: cubit.typeStyle,
                                                selectDate: DateTime.now(),
                                              ),
                                            ],
                                          ),
                                      separatorBuilder: (context, index) =>
                                          CustomSizedBox(
                                            height: 10,
                                          ),
                                      itemCount: cubit.hospital_today.length),
                                );
                              }),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  buidItemDate(DatesBook dateM) => Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dateM.book_date),
            Spacer(),
            CircleAvatar(
              radius: 13,
              child: Center(
                child: Text(
                  dateM.book_count.toString(),
                ),
              ),
            ),
          ],
        ),
      );

  showBottomSheetHospitals(List<Hospital> list, context2) async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context2,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              list.length,
              (index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: Icon(Icons.house_sharp),
                  title: CustomText(
                    list[index].hsptl_name,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: Row(
                    children: [
                      CustomText(
                        DateFormat.jm().format(DateTime.parse("2023-01-01 " +
                            list[index].appointments[0].apnt_from_time)),
                        color: textGrayColor,
                      ),
                      CustomText(
                        ' - ',
                        color: textGrayColor,
                      ),
                      CustomText(
                        DateFormat.jm().format(DateTime.parse("2023-01-01 " +
                            list[index].appointments[0].apnt_to_time)),
                        color: textGrayColor,
                      ),
                    ],
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await Get.to(AddBookPage(
                        selectDate: DateTime.now(),
                        doctor: user_doctor!.doctor!,
                        hospital: MyAppointmentsCubit.get(context2)
                            .hospital_today[index]));
                    MyAppointmentsCubit.get(context2).getHospitalDataToday(
                      DateTime.now(),
                      user_doctor!.doctor!.doc_no,
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
