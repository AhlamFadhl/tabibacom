import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/screens/add_book/add_book_page.dart';
import 'package:tabibacom_doctor/screens/list_book_details/cubit/cubit.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class ListBookDetailsPage extends StatelessWidget {
  ListBookDetailsPage(
      {required this.doctor,
      required this.hospital,
      required this.currentDate,
      this.recordCount = 0,
      required this.isHestory});
  Doctor doctor;
  Hospital hospital;
  DateTime currentDate;
  int recordCount;
  bool isHestory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookDetailsCubit(
          doctor: doctor, hospital: hospital, currentDate: currentDate)
        ..getBookDetails(),
      child: BlocConsumer<BookDetailsCubit, BookDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BookDetailsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(DateFormat.yMMMd().format(cubit.currentDate)),
              actions: [
                IconButton(
                  onPressed: () {
                    cubit.selectDate(context);
                  },
                  icon: Icon(
                    Icons.date_range,
                  ),
                ),
                if (!isHestory)
                  IconButton(
                    onPressed: () async {
                      var value = await Get.to(AddBookPage(
                        selectDate: currentDate,
                        doctor: doctor,
                        hospital: hospital,
                      ));

                      cubit.getBookDetails();
                    },
                    icon: Icon(
                      Icons.add,
                    ),
                  ),
                IconButton(
                  onPressed: () {
                    cubit.getBookDetails();
                  },
                  icon: Icon(
                    Icons.refresh,
                  ),
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: ConditionalBuilder(
                condition: state is! BookDetailsLoadingState,
                fallback: (context) => const CustomProgressIndicator(),
                builder: (context) => ConditionalBuilder(
                    condition: cubit.list_book_details.isNotEmpty,
                    fallback: (context) => Center(
                            child: CustomText(
                          'لايوجد حجوزات في الوقت الحالي',
                          color: textGrayColor,
                        )),
                    builder: (context) {
                      return ListView.separated(
                        itemBuilder: (context, index) => buidItemBook(
                            cubit.list_book_details[index], index + 1, context,
                            isHistory: isHestory, isNext: !isHestory),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: cubit.list_book_details.length,
                      );
                    }),
              ),
            ),
          );
        },
      ),
    );
  }
}
