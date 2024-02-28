import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/screens/add_my_hospital/add_my_hospital_page.dart';
import 'package:tabibacom_doctor/screens/home/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/home/cubit/states.dart';
import 'package:tabibacom_doctor/screens/list_hospital/list_hospital_page.dart';
import 'package:tabibacom_doctor/screens/my_center_appointments/my_center_appointments.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_image.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_shadow.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return SwipeRefresh.material(
              onRefresh: cubit.refresh_User,
              stateStream: cubit.stream1,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 20, top: 20),
                        child: CustomText(
                          'مرحباً ...',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ConditionalBuilder(
                          condition: user_doctor!.doctor != null,
                          builder: (context) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDoctorItem_Main(user_doctor!.doctor!),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 20, bottom: 10),
                                child: CustomText(
                                  'المراكز الطبيه',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  child: (user_doctor!.doctor!.hospital_owner ==
                                          null)
                                      ? CustomShadow(
                                          child: MaterialButton(
                                            padding: const EdgeInsetsDirectional
                                                .symmetric(vertical: 10),
                                            child: ListTile(
                                              trailing: Icon(
                                                Icons.add_home_rounded,
                                                size: 40,
                                                color: Colors.grey.shade400,
                                              ),
                                              leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: CustomImage(
                                                    url: '',
                                                  )),
                                              title: Text(
                                                'إضافة عيادتي',
                                              ),
                                            ),
                                            onPressed: () async {
                                              Hospital? hospital = await Get.to(
                                                  AddMyHospitalPage());
                                              if (hospital != null)
                                                cubit
                                                    .addHospitalOwner(hospital);
                                            },
                                          ),
                                        )
                                      : buildHospitalCard(
                                          user_doctor!.doctor!.hospital_owner!,
                                          context)),
                              CustomSizedBox(height: 20),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildHospitalCard(
                                          user_doctor!
                                              .doctor!.lstHospital![index],
                                          context),
                                  separatorBuilder: (context, index) =>
                                      CustomSizedBox(height: 20),
                                  itemCount:
                                      user_doctor!.doctor!.lstHospital!.length),
                              InkWell(
                                splashColor: secondColor,
                                highlightColor: Colors.white,
                                onTap: () {
                                  cubit.selectHospital();
                                },
                                child: DottedBorder(
                                  dashPattern: [7, 7],
                                  color: primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: primaryColor,
                                        ),
                                        CustomSizedBox(
                                          width: 5,
                                        ),
                                        CustomText(
                                          'إضافة مركز طبي',
                                          color: primaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          fallback: (context) => Container(),
                        ),
                      ),
                      ////****************** /////

                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
