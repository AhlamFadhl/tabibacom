import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tabibacom_doctor/models/appointment_details_model.dart';
import 'package:tabibacom_doctor/models/appointment_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/models/type_model.dart';
import 'package:tabibacom_doctor/screens/appointments_settings/cubit/cubit.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/styles/styles.dart';

class AppointmentsSettingsPage extends StatelessWidget {
  String title;
  List<AppointmentDetails>? appointmentDetails;
  Hospital hsptl;
  AppointmentsSettingsPage({
    required this.title,
    required this.appointmentDetails,
    required this.hsptl,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentsSettingsCubit()
        ..setAppointmentsDetails(appointmentDetails),
      child:
          BlocConsumer<AppointmentsSettingsCubit, AppointmentsSettingsStates>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AppointmentsSettingsSaved) {
            showToast(text: 'تم الحفظ', state: ToastStates.SUCCESS);
            Get.back(result: state.appointmentDetails);
          } else if (state is AppointmentsSettingsError) {
            showToast(text: 'حدث خطأ', state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = AppointmentsSettingsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    title,
                    maxLines: 2,
                  )),
              actions: [
                TextButton(
                    onPressed: () {
                      appointmentDetails = [
                        AppointmentDetails(
                          id: 0,
                          apnt_no: (appointmentDetails != null &&
                                  appointmentDetails!.length > 0)
                              ? appointmentDetails![0].apnt_no
                              : 0,
                          doc_no: user_doctor!.doctor!.doc_no,
                          hsptl_no: hsptl.hsptl_no,
                          apnt_day: 1,
                          apnt_from_time: cubit.list_times_from[0].text,
                          apnt_to_time: cubit.list_times_to[0].text,
                          apnt_count: (cubit.satDay &&
                                  cubit.dropdownValueAttend.type_id == 2)
                              ? int.tryParse(
                                  cubit.list_controller_counts[0].text)!
                              : 0,
                          apnt_period: (cubit.satDay &&
                                  cubit.dropdownValueAttend.type_id == 1)
                              ? cubit.list_model_periods[0].type_id
                              : 0,
                          apnt_avalible: cubit.satDay ? 1 : 0,

                          ///
                          apnt_type: cubit.dropdownValueType.type_id,
                          apnt_prevent: 1,
                          attend_way: cubit.dropdownValueAttend.type_id,
                        ),
                        AppointmentDetails(
                          id: 0,
                          apnt_no: (appointmentDetails != null &&
                                  appointmentDetails!.length > 0)
                              ? appointmentDetails![0].apnt_no
                              : 0,
                          doc_no: user_doctor!.doctor!.doc_no,
                          hsptl_no: hsptl.hsptl_no,
                          apnt_day: 2,
                          apnt_from_time: cubit.list_times_from[1].text,
                          apnt_to_time: cubit.list_times_to[1].text,
                          apnt_count: (cubit.sunDay &&
                                  cubit.dropdownValueAttend.type_id == 2)
                              ? int.tryParse(
                                  cubit.list_controller_counts[1].text)!
                              : 0,
                          apnt_period: (cubit.sunDay &&
                                  cubit.dropdownValueAttend.type_id == 1)
                              ? cubit.list_model_periods[1].type_id
                              : 0,
                          apnt_avalible: cubit.sunDay ? 1 : 0,
                        ),
                        AppointmentDetails(
                          id: 0,
                          apnt_no: (appointmentDetails != null &&
                                  appointmentDetails!.length > 0)
                              ? appointmentDetails![0].apnt_no
                              : 0,
                          doc_no: user_doctor!.doctor!.doc_no,
                          hsptl_no: hsptl.hsptl_no,
                          apnt_day: 3,
                          apnt_from_time: cubit.list_times_from[2].text,
                          apnt_to_time: cubit.list_times_to[2].text,
                          apnt_count: (cubit.monDay &&
                                  cubit.dropdownValueAttend.type_id == 2)
                              ? int.tryParse(
                                  cubit.list_controller_counts[2].text)!
                              : 0,
                          apnt_period: (cubit.monDay &&
                                  cubit.dropdownValueAttend.type_id == 1)
                              ? cubit.list_model_periods[2].type_id
                              : 0,
                          apnt_avalible: cubit.monDay ? 1 : 0,
                        ),
                        AppointmentDetails(
                          id: 0,
                          apnt_no: (appointmentDetails != null &&
                                  appointmentDetails!.length > 0)
                              ? appointmentDetails![0].apnt_no
                              : 0,
                          doc_no: user_doctor!.doctor!.doc_no,
                          hsptl_no: hsptl.hsptl_no,
                          apnt_day: 4,
                          apnt_from_time: cubit.list_times_from[3].text,
                          apnt_to_time: cubit.list_times_to[3].text,
                          apnt_count: (cubit.tuesDay &&
                                  cubit.dropdownValueAttend.type_id == 2)
                              ? int.tryParse(
                                  cubit.list_controller_counts[3].text)!
                              : 0,
                          apnt_period: (cubit.tuesDay &&
                                  cubit.dropdownValueAttend.type_id == 1)
                              ? cubit.list_model_periods[3].type_id
                              : 0,
                          apnt_avalible: cubit.tuesDay ? 1 : 0,
                        ),
                        AppointmentDetails(
                          id: 0,
                          apnt_no: (appointmentDetails != null &&
                                  appointmentDetails!.length > 0)
                              ? appointmentDetails![0].apnt_no
                              : 0,
                          doc_no: user_doctor!.doctor!.doc_no,
                          hsptl_no: hsptl.hsptl_no,
                          apnt_day: 5,
                          apnt_from_time: cubit.list_times_from[4].text,
                          apnt_to_time: cubit.list_times_to[4].text,
                          apnt_count: (cubit.wednesDay &&
                                  cubit.dropdownValueAttend.type_id == 2)
                              ? int.tryParse(
                                  cubit.list_controller_counts[4].text)!
                              : 0,
                          apnt_period: (cubit.wednesDay &&
                                  cubit.dropdownValueAttend.type_id == 1)
                              ? cubit.list_model_periods[4].type_id
                              : 0,
                          apnt_avalible: cubit.wednesDay ? 1 : 0,
                        ),
                        AppointmentDetails(
                          id: 0,
                          apnt_no: (appointmentDetails != null &&
                                  appointmentDetails!.length > 0)
                              ? appointmentDetails![0].apnt_no
                              : 0,
                          doc_no: user_doctor!.doctor!.doc_no,
                          hsptl_no: hsptl.hsptl_no,
                          apnt_day: 6,
                          apnt_from_time: cubit.list_times_from[5].text,
                          apnt_to_time: cubit.list_times_to[5].text,
                          apnt_count: (cubit.thursDay &&
                                  cubit.dropdownValueAttend.type_id == 2)
                              ? int.tryParse(
                                  cubit.list_controller_counts[5].text)!
                              : 0,
                          apnt_period: (cubit.thursDay &&
                                  cubit.dropdownValueAttend.type_id == 1)
                              ? cubit.list_model_periods[5].type_id
                              : 0,
                          apnt_avalible: cubit.thursDay ? 1 : 0,
                        ),
                        AppointmentDetails(
                          id: 0,
                          apnt_no: (appointmentDetails != null &&
                                  appointmentDetails!.length > 0)
                              ? appointmentDetails![0].apnt_no
                              : 0,
                          doc_no: user_doctor!.doctor!.doc_no,
                          hsptl_no: hsptl.hsptl_no,
                          apnt_day: 7,
                          apnt_from_time: cubit.list_times_from[6].text,
                          apnt_to_time: cubit.list_times_to[6].text,
                          apnt_count: (cubit.friDay &&
                                  cubit.dropdownValueAttend.type_id == 2)
                              ? int.tryParse(
                                  cubit.list_controller_counts[6].text)!
                              : 0,
                          apnt_period: (cubit.friDay &&
                                  cubit.dropdownValueAttend.type_id == 1)
                              ? cubit.list_model_periods[6].type_id
                              : 0,
                          apnt_avalible: cubit.friDay ? 1 : 0,
                        ),
                      ];
                      Appointment apnt = Appointment(
                        apnt_no: (appointmentDetails != null &&
                                appointmentDetails!.length > 0)
                            ? appointmentDetails![0].apnt_no
                            : 0,
                        doc_no: user_doctor!.doctor!.doc_no,
                        hsptl_no: hsptl.hsptl_no,
                        apnt_type: cubit.dropdownValueType.type_id,
                        apnt_prevent: 1,
                        attend_way: cubit.dropdownValueAttend.type_id,
                        details: appointmentDetails,
                      );
                      cubit.updateAppointments(apnt, context);
                    },
                    child: CustomText(
                      'حفظ',
                      color: Colors.white,
                    )),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            'تأكيد الحجز',
                            style: styleText,
                          ),
                        ),
                        Expanded(
                          child: DropdownButton<TypeModel>(
                            isExpanded: true,
                            value: cubit.dropdownValueType,
                            items: list_type_appoint
                                .map<DropdownMenuItem<TypeModel>>(
                                    (TypeModel value) {
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
                              cubit.changeApnt_type(newValue);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            'نوع الحجز',
                            style: styleText,
                          ),
                        ),
                        Expanded(
                          child: DropdownButton<TypeModel>(
                            isExpanded: true,
                            value: cubit.dropdownValueAttend,
                            items: list_type_attend
                                .map<DropdownMenuItem<TypeModel>>(
                                    (TypeModel value) {
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
                              cubit.changeAttend_way(newValue);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'ساعات العمل',
                      style: styleHeadline,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            cubit.changeCheckSatDay();
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                  value: cubit.satDay,
                                  onChanged: (value) {
                                    cubit.changeCheckSatDay();
                                  }),
                              Text(
                                'السبت',
                                style: styleText,
                              ),
                            ],
                          ),
                        ),
                        if (cubit.satDay) buildTimeDetailsCard(context, 1)
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => cubit.changeCheckSunDay(),
                          child: Row(
                            children: [
                              Checkbox(
                                value: cubit.sunDay,
                                onChanged: (value) {
                                  cubit.changeCheckSunDay();
                                },
                              ),
                              Text(
                                'الأحد',
                                style: styleText,
                              ),
                            ],
                          ),
                        ),
                        if (cubit.sunDay) buildTimeDetailsCard(context, 2)
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => cubit.changeCheckMonDay(),
                          child: Row(
                            children: [
                              Checkbox(
                                value: cubit.monDay,
                                onChanged: (value) {
                                  cubit.changeCheckMonDay();
                                },
                              ),
                              Text(
                                'الأثنين',
                                style: styleText,
                              ),
                            ],
                          ),
                        ),
                        if (cubit.monDay) buildTimeDetailsCard(context, 3)
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => cubit.changeCheckTuesday(),
                          child: Row(
                            children: [
                              Checkbox(
                                value: cubit.tuesDay,
                                onChanged: (value) {
                                  cubit.changeCheckTuesday();
                                },
                              ),
                              Text(
                                'الثلاثاء',
                                style: styleText,
                              ),
                            ],
                          ),
                        ),
                        if (cubit.tuesDay) buildTimeDetailsCard(context, 4)
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => cubit.changeCheckWednesDay(),
                          child: Row(
                            children: [
                              Checkbox(
                                value: cubit.wednesDay,
                                onChanged: (value) {
                                  cubit.changeCheckWednesDay();
                                },
                              ),
                              Text(
                                'الأربعاء',
                                style: styleText,
                              ),
                            ],
                          ),
                        ),
                        if (cubit.wednesDay) buildTimeDetailsCard(context, 5)
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => cubit.changeCheckThursDay(),
                          child: Row(
                            children: [
                              Checkbox(
                                value: cubit.thursDay,
                                onChanged: (value) {
                                  cubit.changeCheckThursDay();
                                },
                              ),
                              Text(
                                'الخميس',
                                style: styleText,
                              ),
                            ],
                          ),
                        ),
                        if (cubit.thursDay) buildTimeDetailsCard(context, 6)
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => cubit.changeCheckFriDay(),
                          child: Row(
                            children: [
                              Checkbox(
                                value: cubit.friDay,
                                onChanged: (value) {
                                  cubit.changeCheckFriDay();
                                },
                              ),
                              Text(
                                'الجمعة',
                                style: styleText,
                              ),
                            ],
                          ),
                        ),
                        if (cubit.friDay) buildTimeDetailsCard(context, 7)
                      ],
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

  buildTimeDetailsCard(context, day) => Container(
        padding: const EdgeInsets.all(8),
        // color: Colors.white,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الفترة',
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      AppointmentsSettingsCubit.get(context).selectTime(
                          context,
                          day,
                          AppointmentsSettingsCubit.get(context)
                              .list_times_from[day - 1]
                              .text,
                          1);
                    },
                    child: defaultTextField(
                        isClickable: false,
                        controller: AppointmentsSettingsCubit.get(context)
                            .list_times_from[day - 1],
                        type: TextInputType.text,
                        validate: (value) {},
                        hinttxt: 'من الساعة'),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      AppointmentsSettingsCubit.get(context).selectTime(
                          context,
                          day,
                          AppointmentsSettingsCubit.get(context)
                              .list_times_to[day - 1]
                              .text,
                          2);
                    },
                    child: defaultTextField(
                        isClickable: false,
                        controller: AppointmentsSettingsCubit.get(context)
                            .list_times_to[day - 1],
                        type: TextInputType.text,
                        validate: (value) {},
                        hinttxt: 'الى الساعة'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            if (AppointmentsSettingsCubit.get(context)
                    .dropdownValueAttend
                    .type_id ==
                1)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مدة الكشف',
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DropdownButton<TypeModel>(
                    isExpanded: true,
                    value: AppointmentsSettingsCubit.get(context)
                        .list_model_periods[day - 1],
                    items: list_periods
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
                      AppointmentsSettingsCubit.get(context)
                          .changePeriod(newValue, day);
                    },
                  ),
                ],
              ),
            if (AppointmentsSettingsCubit.get(context)
                    .dropdownValueAttend
                    .type_id ==
                2)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'عدد الحجوزات',
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: defaultTextField(
                        controller: AppointmentsSettingsCubit.get(context)
                            .list_controller_counts[day - 1],
                        type: TextInputType.number,
                        validate: (value) {},
                        onChange: (value) {
                          AppointmentsSettingsCubit.get(context)
                              .changeCount(value, day);
                        },
                        hinttxt: 'العدد'),
                  ),
                ],
              ),
          ],
        ),
      );
}
