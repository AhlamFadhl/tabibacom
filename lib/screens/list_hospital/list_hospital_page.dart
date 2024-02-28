import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:tabibacom_doctor/screens/list_hospital/cubit/cubit.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text_field.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class ListHospitalPage extends StatelessWidget {
  const ListHospitalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListHospitalCubit()..getHospitals(),
      child: BlocConsumer<ListHospitalCubit, ListHospitalState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ListHospitalCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'قائمة المراكز الطبية',
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: SwipeRefresh.material(
                stateStream: cubit.stream1,
                onRefresh: () {
                  cubit.getHospitals();
                },
                children: [
                  CustomTextField(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'ابحث',
                    onChanged: (value) {
                      cubit.SearchHospitals(value);
                    },
                  ),
                  CustomSizedBox(
                    height: 10,
                  ),
                  ConditionalBuilder(
                      condition: !cubit.isLoading,
                      fallback: (context) => CustomProgressIndicator(),
                      builder: (context) {
                        return ConditionalBuilder(
                            condition: cubit.list_hospitals.isNotEmpty,
                            fallback: (context) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.list,
                                      size: 50,
                                      color: textGrayColor,
                                    ),
                                    CustomText(
                                      'لا يوحد مراكز طبية',
                                      color: textGrayColor,
                                    ),
                                  ],
                                ),
                            builder: (context) {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            CustomText(cubit
                                                .list_hospitals[index]
                                                .hsptl_name),
                                            Spacer(),
                                            cubit.list_hospitals[index]
                                                    .isLoading
                                                ? CustomProgressIndicator()
                                                : IconButton(
                                                    onPressed: () {
                                                      cubit.alertShowHospital(
                                                          index, context);
                                                    },
                                                    icon: Icon(cubit
                                                            .list_hospitals[
                                                                index]
                                                            .isadded
                                                        ? Icons.delete
                                                        : Icons.add),
                                                  ),
                                          ],
                                        ),
                                      ),
                                  separatorBuilder: (context, index) => Divider(
                                        height: 1,
                                      ),
                                  itemCount: cubit.list_hospitals.length);
                            });
                      }),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
