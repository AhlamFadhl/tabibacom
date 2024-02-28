import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabibacom_doctor/models/appointment_details_model.dart';
import 'package:tabibacom_doctor/models/book_model.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class SelectTimePage extends StatefulWidget {
  DateTime selectDate;
  Doctor doctor;
  Hospital hospital;
  SelectTimePage(
      {super.key,
      required this.selectDate,
      required this.doctor,
      required this.hospital});

  @override
  State<SelectTimePage> createState() => _SelectTimePageState();
}

class _SelectTimePageState extends State<SelectTimePage> {
  List<DateTime> list_times = [];
  List<int> list_int = [];
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list_times = getTimes();
  }

  getTimes() {
    List<DateTime> list = [];
    if (widget.hospital.appointments != null &&
        widget.hospital.appointments.isNotEmpty) {
      AppointmentDetails apnt = widget.hospital.appointments
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
    getDetailsBookDate();
    return list;
  }

  Future<void> getDetailsBookDate() async {
    List<BookModel> list_book = [];
    try {
      var value = await DioHelper.postData(url: BOOK_DOCTOR_DATE, data: {
        'doc': widget.doctor.doc_no,
        'hsptl': widget.hospital.hsptl_no,
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
        if (bk.length != 0)
          list_int.add(1);
        else
          list_int.add(0);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اختر وقت'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: isLoading
            ? CustomProgressIndicator()
            : SingleChildScrollView(
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: List.generate(
                      list_times.length,
                      (i) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () {
                            if ((list_int.length > 0 && list_int[i] == 0) ||
                                list_int.length == 0) {
                              Get.back(result: list_times[i]);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: 100,
                            decoration: BoxDecoration(
                              color:
                                  ((list_int.length > 0 && list_int[i] == 0) ||
                                          list_int.length == 0)
                                      ? secondColor.withOpacity(0.7)
                                      : textGrayColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              child: Center(
                                child: CustomText(
                                  DateFormat.jm().format(list_times[i]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
