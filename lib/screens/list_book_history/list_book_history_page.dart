import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibacom_doctor/layout/schedule/cubit/cubit.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class ListBookHistoryPage extends StatelessWidget {
  const ListBookHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduleCubit, ScheduleState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ScheduleCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: ConditionalBuilder(
              condition: !cubit.isLoadingHistory,
              fallback: (context) => const CustomProgressIndicator(),
              builder: (context) => ConditionalBuilder(
                  condition: cubit.list_book_history.isNotEmpty,
                  fallback: (context) => Center(
                          child: CustomText(
                        'لايوجد حجوزات في الوقت الحالي',
                        color: textGrayColor,
                      )),
                  builder: (context) {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildCardDateBook(
                            cubit.list_book_history[index],
                            true,
                            cubit.doctor,
                            cubit.hospital),
                        separatorBuilder: (context, index) => CustomSizedBox(
                              height: 10,
                            ),
                        itemCount: cubit.list_book_history.length);
                  }),
            ),
          ),
        );
      },
    );
  }
}
