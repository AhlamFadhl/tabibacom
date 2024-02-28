import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:tabibacom_doctor/layout/schedule/cubit/cubit.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class ListBookNextPage extends StatelessWidget {
  const ListBookNextPage({super.key});

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
              condition: !cubit.isLoadingNext,
              fallback: (context) => const CustomProgressIndicator(),
              builder: (context) => ConditionalBuilder(
                  fallback: (context) => Center(
                          child: CustomText(
                        'لايوجد مواعيد عمل قادمه',
                        color: textGrayColor,
                      )),
                  condition: cubit.list_book_next.isNotEmpty,
                  builder: (context) {
                    return ListView.separated(
                        controller: cubit.scrollController,
                        itemBuilder: (context, index) {
                          if (index == cubit.list_book_next.length &&
                              cubit.list_book_next.length != 0) {
                            return CustomProgressIndicator();
                          } else {
                            return buildCardDateBook(
                                cubit.list_book_next[index],
                                false,
                                cubit.doctor,
                                cubit.hospital,
                                index: index,
                                context: context);
                          }
                        },
                        separatorBuilder: (context, index) => CustomSizedBox(
                              height: 10,
                            ),
                        itemCount: cubit.list_book_next.length + 1);
                  }),
            ),
          ),
        );
      },
    );
  }
}
