import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/screens/add_my_hospital/add_my_hospital_page.dart';
import 'package:tabibacom_doctor/screens/add_my_hospital/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/appointments_settings/appointments_settings_page.dart';
import 'package:tabibacom_doctor/screens/my_center_appointments/cubit/cubit.dart';
import 'package:tabibacom_doctor/layout/schedule/schedule_page.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_button_widget.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_image.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';
import 'package:tabibacom_doctor/shared/styles/styles.dart';

class MyCenterAppointments extends StatelessWidget {
  Hospital hsptl;
  bool isOwner;
  MyCenterAppointments({required this.hsptl, required this.isOwner});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyHospitalSettingsCubit(hsptl: hsptl),
      child: BlocConsumer<MyHospitalSettingsCubit, MyHospitalSettingsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = MyHospitalSettingsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'مواعيدي في ' + cubit.hsptl.hsptl_name,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 31,
                          backgroundColor: primaryColor,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade100),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: CustomImage(
                              fit: BoxFit.cover,
                              url: PATH_IMAGES + (cubit.hsptl.hsptl_logo ?? ''),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cubit.hsptl.hsptl_name,
                              textAlign: TextAlign.start,
                              style:
                                  styleText_mini_colored.copyWith(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              cubit.hsptl.hsptl_address ?? '',
                              textAlign: TextAlign.start,
                              style: styleText.copyWith(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                        if (isOwner) Spacer(),
                        if (isOwner)
                          IconButton(
                              onPressed: () {
                                Get.to(AddMyHospitalPage(
                                  isEditing: true,
                                  hospital: cubit.hsptl,
                                ));
                              },
                              icon: Icon(Icons.edit)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'مواعيد العمل',
                      style: styleHeadline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (cubit.hsptl.appointments == null ||
                        cubit.hsptl.appointments.length == 0)
                      Center(
                        child: Container(
                          child: Column(
                            children: [
                              Image.asset('assets/images/schedule.jpg'),
                              CustomText(
                                'لا يوجد مواعيد عمل',
                                color: textGrayColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              CustomSizedBox(
                                height: 5,
                              ),
                              CustomText(
                                'الرجاء إضافة مواعيد دوامك في المركز',
                                color: textGrayColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (cubit.hsptl.appointments != null)
                      buildTimeTable(cubit.hsptl.appointments),
                    if (cubit.hsptl.appointments != null &&
                        cubit.hsptl.appointments.length != 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomSizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('تــأكيد الحجز'),
                              Text(
                                cubit.hsptl.appointments[0].apnt_type == 1
                                    ? 'يومي'
                                    : 'اسبوعي',
                              ),
                            ],
                          ),
                          CustomSizedBox(
                            height: 10,
                          ),
                          Divider(),
                        ],
                      ),
                    if (cubit.hsptl.appointments != null &&
                        cubit.hsptl.appointments.length != 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomSizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('نوع الحجز'),
                              Text(
                                cubit.hsptl.appointments[0].attend_way == 1
                                    ? 'الحضور حسب الوقت المحدد'
                                    : 'الدخول بأسبقة الحضور',
                                style: styleText_mini_colored.copyWith(
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    CustomSizedBox(
                      height: 20,
                    ),
                    CustomButtonWidget(
                        onTap: () async {
                          var result =
                              await Get.to(() => AppointmentsSettingsPage(
                                    title:
                                        'المواعيد في ' + cubit.hsptl.hsptl_name,
                                    appointmentDetails:
                                        cubit.hsptl.appointments,
                                    hsptl: cubit.hsptl,
                                  ));

                          if (result != null) {
                            cubit.changeAppointmentsData(result);
                          }
                        },
                        title: (cubit.hsptl.appointments == null)
                            ? 'إضافة المواعيد'
                            : 'تعديل اعدادت المواعيد'),
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
