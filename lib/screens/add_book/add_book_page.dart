import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabibacom_doctor/models/book_model.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/models/patient_model.dart';
import 'package:tabibacom_doctor/screens/add_book/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/add_book/select_time_page.dart';
import 'package:tabibacom_doctor/screens/list_patients/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/list_patients/list_patients_page.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text_field.dart';

class AddBookPage extends StatelessWidget {
  DateTime selectDate;
  DateTime? selctTime;
  Doctor doctor;
  Hospital hospital;
  AddBookPage(
      {super.key,
      required this.selectDate,
      required this.doctor,
      required this.hospital,
      this.selctTime});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddBookCubit(book_date: selectDate, book_time: selctTime),
      child: BlocConsumer<AddBookCubit, AddBookState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AddBookCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('تفاصيل الحجز'),
              actions: [
                InkWell(
                    onTap: () {
                      if (cubit.patient == null) {
                        return;
                      }
                      if (cubit.book_time == null) {
                        return;
                      }

                      BookModel bookModel = BookModel(
                        book_no: 0,
                        book_date: cubit.book_date.toString(),
                        book_time: DateFormat.Hm().format(cubit.book_time!),
                        book_for_you: 0,
                        pt_name: cubit.patient!.ptn_name,
                        pt_phone: cubit.patient!.ptn_phone,
                        ptn_no: cubit.patient!.ptn_no,
                        doc_no: doctor.doc_no,
                        hsptl_no: hospital.hsptl_no,
                        book_state: 0,
                        usr_no: user_doctor!.usr_no,
                        book_from_app: 1,
                        book_note: cubit.controllerNote.text,
                        date_enter: DateTime.now().toString(),
                        book_price: 0,
                        srv_no: 1,
                      );
                      cubit.insertBookAppoinment(bookModel, context);
                    },
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomText(
                        'حفظ',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )))
              ],
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildCardInformationWedgit(
                      'اختر المريض',
                      CustomText((cubit.patient == null)
                          ? ''
                          : cubit.patient!.ptn_name),
                      onPressed: () async {
                        PatientsCubit.get(context)
                            .getPatientsDoctor(user_doctor!.doctor!.doc_no);
                        PatientsDoctor? patientsDoctor =
                            await Get.to(ListPatientsPage(
                          isBooking: true,
                        ));
                        cubit.selectPatient(patientsDoctor);
                      },
                      icon: Icons.arrow_right,
                    ),
                    buildCardInformationWedgit(
                      'حدد التاريخ',
                      CustomText(DateFormat.yMMMd().format(cubit.book_date)),
                      onPressed: () {
                        cubit.selectDate(context);
                      },
                      icon: Icons.arrow_drop_down_outlined,
                    ),
                    buildCardInformationWedgit(
                        'حدد الوقت',
                        CustomText(
                          cubit.book_time == null
                              ? ''
                              : DateFormat.jm().format(cubit.book_time!),
                        ), onPressed: () async {
                      if (hospital.appointments == null) {
                        cubit.selectTime(context);
                        return;
                      }
                      if (hospital.appointments[0].attend_way == 2) {
                        cubit.selectTime(context);
                      } else {
                        var time = await Get.to(SelectTimePage(
                            selectDate: selectDate,
                            doctor: doctor,
                            hospital: hospital));
                        if (time != null) {
                          cubit.setTime(time);
                        }
                      }
                    }, icon: Icons.arrow_drop_down_outlined),
                    buildCardInformationWedgit('نوع الخدمه', CustomText('كشف'),
                        onPressed: () {}, icon: Icons.arrow_right),
                    buildCardInformationWedgit(
                        'إضافة ملاحظات',
                        Form(
                          key: cubit.keyForm,
                          child: CustomTextField(
                            controller: cubit.controllerNote,
                            hintText: 'ملاحظة',
                            maxLines: null,
                          ),
                        ),
                        onPressed: () {},
                        icon: Icons.text_snippet),
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
