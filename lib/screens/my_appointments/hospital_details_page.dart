import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabibacom_doctor/models/appointment_details_model.dart';
import 'package:tabibacom_doctor/models/book_details_model.dart';
import 'package:tabibacom_doctor/models/book_model.dart';
import 'package:tabibacom_doctor/models/dates_book_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/screens/add_book/add_book_page.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_border.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/utils/error_handler.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';
import 'package:tabibacom_doctor/shared/styles/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HospitalDetailsAppointmentsPage extends StatefulWidget {
  Hospital hospital_today;
  int typeStyle;
  DateTime selectDate;

  HospitalDetailsAppointmentsPage({
    super.key,
    required this.hospital_today,
    required this.typeStyle,
    required this.selectDate,
  });

  @override
  State<HospitalDetailsAppointmentsPage> createState() =>
      _HospitalDetailsAppointmentsPageState();
}

class _HospitalDetailsAppointmentsPageState
    extends State<HospitalDetailsAppointmentsPage> {
  bool isLoading = true;
  List<BookModel> list_book_today = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.typeStyle == 1) {
      getBookAppoientmens(user_doctor!.doctor!.doc_no);
    } else if (widget.typeStyle == 2) {
      if (widget.hospital_today.appointments[0].attend_way == 1)
        getTimes();
      else {
        getBookAppoientmens(user_doctor!.doctor!.doc_no);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (isLoading)
          ? CustomProgressIndicator()
          : ConditionalBuilder(
              condition: (list_book_today.isEmpty),
              builder: (context) => Center(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: Colors.grey.shade100,
                  padding: const EdgeInsets.all(40),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: (widget.hospital_today.appointments != null &&
                          widget.hospital_today.appointments[0].apnt_avalible ==
                              1)
                      ? CustomText(
                          'لا يوجد حجز',
                          color: textGrayColor,
                        )
                      : CustomText(
                          'لا يوجد دوام عمل في هذا اليوم',
                          color: textGrayColor,
                        ),
                ),
              ),
              fallback: (context) => SingleChildScrollView(
                child: ConditionalBuilder(
                  condition: widget.typeStyle == 1,
                  builder: (context) {
                    return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buidItemBook(
                              list_book_today[index],
                              index + 1,
                              context,
                              onSelected: (value) {
                                int state = 0;
                                if (value == 'في الانتظار') {
                                  state = 2;
                                } else if (value == 'في الداخل') {
                                  state = 3;
                                } else if (value == 'طلب فحص') {
                                  state = 4;
                                } else if (value == 'الإنتهاء') {
                                  state = 5;
                                } else if (value == 'الغاء') {
                                  state = 6;
                                }

                                updateStatusBookAppointment(
                                  index,
                                  state,
                                  list_book_today[index],
                                );
                              },
                            ),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: list_book_today.length);
                  },
                  fallback: (context) => Container(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: List.generate(
                          list_book_today.length,
                          (index) => CustomBorder(
                              margin: const EdgeInsets.all(8),
                              color: list_book_today[index].pt_name.isNotEmpty
                                  ? getColorBookStatus(
                                          list_book_today[index].book_state)
                                      .withOpacity(0.5)
                                  : Colors.white,
                              child: Container(
                                width: 100,
                                height: 80,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (list_book_today[index].book_no ==
                                            0) {
                                          Get.to(AddBookPage(
                                            selectDate: widget.selectDate,
                                            selctTime: DateTime.parse(
                                                '2023-01-01 ' +
                                                    list_book_today[index]
                                                        .book_time),
                                            doctor: user_doctor!.doctor!,
                                            hospital: widget.hospital_today,
                                          ));
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        alignment: AlignmentDirectional.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              DateFormat.jm().format(
                                                DateTime.parse('2023-01-01 ' +
                                                    list_book_today[index]
                                                        .book_time),
                                              ),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            if (list_book_today[index]
                                                    .book_no !=
                                                0)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Flexible(
                                                    child: CustomText(
                                                  list_book_today[index]
                                                      .pt_name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (list_book_today[index].book_no != 0)
                                      Positioned(
                                        bottom: -15,
                                        child: PopupMenuButton(
                                          onSelected: (value) {
                                            int state = 0;
                                            if (value == 'في الانتظار') {
                                              state = 2;
                                            } else if (value == 'في الداخل') {
                                              state = 3;
                                            } else if (value == 'طلب فحص') {
                                              state = 4;
                                            } else if (value == 'الإنتهاء') {
                                              state = 5;
                                            } else if (value == 'الغاء') {
                                              state = 6;
                                            }

                                            updateStatusBookAppointment(
                                              index,
                                              state,
                                              list_book_today[index],
                                            );
                                          },
                                          itemBuilder: (context) {
                                            return {
                                              'في الانتظار',
                                              'في الداخل',
                                              'طلب فحص',
                                              'الغاء',
                                              'الإنتهاء'
                                            }.map((String choice) {
                                              return PopupMenuItem<String>(
                                                value: choice,
                                                child: Text(
                                                  choice,
                                                  style: styleText.copyWith(
                                                      fontSize: 12),
                                                ),
                                              );
                                            }).toList();
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ))),
                    ),
                  ),
                ),
              ),
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

  ////Functions////
  updateStatusBookAppointment(index, state, BookModel book) {
    BookDetails details = BookDetails(
        book_no: book.book_no,
        book_state: state,
        book_user: user_doctor!.usr_no,
        datetime_enter: DateTime.now().toString());
    DioHelper.postData(url: BOOK_DETAILS_NEW, data: details.toJson())
        .then((value) {
      if (value.data['status'] == 1) {
        setState(() {
          list_book_today[index].book_state = state;
        });
      } else {
        setState(() {});
      }
    }).catchError((error) {
      print(error);
      setState(() {
        ErrorHandler.handleError(error);
      });
    });
  }

  getBookAppoientmens(doc) {
    String date_temp = '';

    DioHelper.postData(url: BOOK_DOCTOR_DATE, data: {
      'doc': user_doctor!.doctor!.doc_no,
      'hsptl': widget.hospital_today.hsptl_no,
      'date': DateFormat('yyyy-MM-dd').format(widget.selectDate)
    }).then((value) {
      print(value);
      if (value.statusCode == 200) {
        List<dynamic> list = value.data;
        list_book_today = list.map((json) => BookModel.fromJson(json)).toList();
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      print(error);
      isLoading = false;
      ErrorHandler.handleError(error);
      setState(() {
        isLoading = false;
      });
    });
  }

////Style 2
  getTimes() {
    isLoading = true;
    List<DateTime> list = [];
    if (widget.hospital_today.appointments != null &&
        widget.hospital_today.appointments.isNotEmpty) {
      AppointmentDetails apnt = widget.hospital_today.appointments
          .where((element) =>
              element.apnt_day == convertWeekDayNo(widget.selectDate.weekday))
          .toList()[0];

      if (!(apnt.apnt_avalible == 0)) {
        var date = DateTime.parse(
            DateFormat('yyyy-MM-dd').format(widget.selectDate) +
                ' ' +
                apnt.apnt_from_time); //apnt.apnt_from_time
        var secondDate = DateTime.parse(
                DateFormat('yyyy-MM-dd').format(widget.selectDate) +
                    ' ' +
                    apnt.apnt_to_time) // apnt.apnt_to_time
            .add(Duration(minutes: (apnt.apnt_period * -2)));
        list.add(date);
        while (
            date.millisecondsSinceEpoch < secondDate.millisecondsSinceEpoch) {
          date = date.add(Duration(minutes: apnt.apnt_period));
          list.add(date);
        }
      }
    }
    getDetailsBookDate(list);
  }

  Future<void> getDetailsBookDate(List<DateTime> list_times) async {
    List<BookModel> list_book = [];
    try {
      var value = await DioHelper.postData(url: BOOK_DOCTOR_DATE, data: {
        'doc': user_doctor!.doctor!.doc_no,
        'hsptl': widget.hospital_today.hsptl_no,
        'date': DateFormat('yyyy-MM-dd').format(widget.selectDate)
      });
      print(value);
      List<dynamic> list = value.data;
      list_book = list.map((json) => BookModel.fromJson(json)).toList();
      list_times.forEach((element) {
        List<BookModel> bk = list_book
            .where((x) =>
                DateFormat.Hm()
                    .format(DateTime.parse("2023-01-01 " + x.book_time)) ==
                DateFormat.Hm().format(element))
            .toList();
        if (bk.isEmpty)
          list_book_today.add(BookModel(
              book_no: 0,
              doc_no: user_doctor!.doctor!.doc_no,
              hsptl_no: widget.hospital_today.hsptl_no,
              usr_no: 0,
              book_for_you: 0,
              ptn_no: 0,
              pt_name: '',
              pt_phone: '',
              srv_no: 0,
              book_price: 0,
              book_date: DateFormat.yMMMd().format(widget.selectDate),
              book_time: DateFormat.Hms().format(element),
              book_state: 0,
              date_enter: DateTime.now().toString()));
        else
          list_book_today.add(bk[0]);
      });
      setState(() {
        isLoading = false;
      });
    } catch (ex) {
      print(ex.toString());
      setState(() {
        isLoading = false;
      });
    }
  }
}
