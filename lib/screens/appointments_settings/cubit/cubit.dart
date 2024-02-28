import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:tabibacom_doctor/models/appointment_details_model.dart';
import 'package:tabibacom_doctor/models/appointment_model.dart';
import 'package:tabibacom_doctor/models/type_model.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/utils/error_handler.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

part 'states.dart';

class AppointmentsSettingsCubit extends Cubit<AppointmentsSettingsStates> {
  AppointmentsSettingsCubit() : super(AppointmentsSettingsInitial());

  static AppointmentsSettingsCubit get(context) => BlocProvider.of(context);

  var dropdownValueType = list_type_appoint[0];
  var dropdownValueAttend = list_type_attend[0];

  setAppointmentsDetails(List<AppointmentDetails>? details) {
    if (details != null && details.length > 0) {
      try {
        dropdownValueType = list_type_appoint
            .where((element) => element.type_id == details[0].apnt_type)
            .toList()[0];
      } catch (ex) {}

      try {
        dropdownValueAttend = list_type_attend
            .where((element) => element.type_id == details[0].attend_way)
            .toList()[0];
      } catch (ex) {}

      satDay = details
                  .where((element) =>
                      (element.apnt_day == 1 && element.apnt_avalible == 0))
                  .toList()
                  .length ==
              0
          ? true
          : false;
      sunDay = details
                  .where((element) =>
                      (element.apnt_day == 2 && element.apnt_avalible == 0))
                  .toList()
                  .length ==
              0
          ? true
          : false;

      monDay = details
                  .where((element) =>
                      (element.apnt_day == 3 && element.apnt_avalible == 0))
                  .toList()
                  .length ==
              0
          ? true
          : false;

      tuesDay = details
                  .where((element) =>
                      (element.apnt_day == 4 && element.apnt_avalible == 0))
                  .toList()
                  .length ==
              0
          ? true
          : false;

      wednesDay = details
                  .where((element) =>
                      (element.apnt_day == 5 && element.apnt_avalible == 0))
                  .toList()
                  .length ==
              0
          ? true
          : false;

      thursDay = details
                  .where((element) =>
                      (element.apnt_day == 6 && element.apnt_avalible == 0))
                  .toList()
                  .length ==
              0
          ? true
          : false;

      friDay = details
                  .where((element) =>
                      (element.apnt_day == 7 && element.apnt_avalible == 0))
                  .toList()
                  .length ==
              0
          ? true
          : false;

      for (var i = 0; i < 7; i++) {
        list_times_from[i].text = DateFormat.Hm()
            .format(DateTime.parse('2023-01-01 ' + details[i].apnt_from_time));
        list_times_to[i].text = DateFormat.Hm()
            .format(DateTime.parse('2023-01-01 ' + details[i].apnt_to_time));

        if (dropdownValueAttend.type_id == 2)
          list_controller_counts[i].text = details[i].apnt_count.toString();

        if (dropdownValueAttend.type_id == 1)
          try {
            list_model_periods[i] = list_periods
                .where((element) => element.type_id == details[i].apnt_period)
                .toList()[0];
          } catch (ex) {}
      }
    }
  }

  var satDay = true;
  var sunDay = false;
  var monDay = false;
  var tuesDay = false;
  var wednesDay = false;
  var thursDay = false;
  var friDay = false;

  changeApnt_type(newValue) {
    dropdownValueType = newValue;
    emit(AppointmentsSettingsChangeType());
  }

  changeAttend_way(newValue) {
    dropdownValueAttend = newValue;
    emit(AppointmentsSettingsChangeAttendWay());
  }

  changeCheckSatDay() {
    satDay = !satDay;
    emit(AppointmentsSettingsChangeCheck());
  }

  changeCheckSunDay() {
    sunDay = !sunDay;
    emit(AppointmentsSettingsChangeCheck());
  }

  changeCheckMonDay() {
    monDay = !monDay;
    emit(AppointmentsSettingsChangeCheck());
  }

  changeCheckTuesday() {
    tuesDay = !tuesDay;
    emit(AppointmentsSettingsChangeCheck());
  }

  changeCheckWednesDay() {
    wednesDay = !wednesDay;
    emit(AppointmentsSettingsChangeCheck());
  }

  changeCheckThursDay() {
    thursDay = !thursDay;
    emit(AppointmentsSettingsChangeCheck());
  }

  changeCheckFriDay() {
    friDay = !friDay;
    emit(AppointmentsSettingsChangeCheck());
  }

  List<TextEditingController> list_controller_counts = [
    TextEditingController(text: '10'),
    TextEditingController(text: '10'),
    TextEditingController(text: '10'),
    TextEditingController(text: '10'),
    TextEditingController(text: '10'),
    TextEditingController(text: '10'),
    TextEditingController(text: '10')
  ];
  List<TypeModel> list_model_periods = [
    list_periods[0],
    list_periods[0],
    list_periods[0],
    list_periods[0],
    list_periods[0],
    list_periods[0],
    list_periods[0]
  ];

  changePeriod(newValue, day) {
    list_model_periods[day - 1] = newValue;
    emit(AppointmentsSettingsChangePeriod());
  }

  changeCount(newValue, day) {
    list_controller_counts[day - 1].text = newValue;
    emit(AppointmentsSettingsChangeCount());
  }

//time
  List<TextEditingController> list_times_from = [
    TextEditingController(text: '10:00'),
    TextEditingController(text: '10:00'),
    TextEditingController(text: '10:00'),
    TextEditingController(text: '10:00'),
    TextEditingController(text: '10:00'),
    TextEditingController(text: '10:00'),
    TextEditingController(text: '10:00')
  ];
  List<TextEditingController> list_times_to = [
    TextEditingController(text: '22:00'),
    TextEditingController(text: '22:00'),
    TextEditingController(text: '22:00'),
    TextEditingController(text: '22:00'),
    TextEditingController(text: '22:00'),
    TextEditingController(text: '22:00'),
    TextEditingController(text: '22:00')
  ];

  Future<void> selectTime(context, day, s, type) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(s.split(":")[0]),
        minute: int.parse(s.split(":")[1]),
      ),
    );
    if (selectedTime != null) {
      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: true);

      if (formattedTime != null) {
        if (type == 1)
          list_times_from[day - 1].text = formattedTime;
        else
          list_times_to[day - 1].text = formattedTime;
      }
      emit(state);
    }
  }

  saveAppointments(Appointment apnt) {
    DioHelper.postData(url: APPOINTMENT_NEW, data: apnt.toJson()).then((value) {
      print(value.data);
    }).catchError((error) {
      print(error);
    });
  }

  updateAppointments(Appointment apnt, context) async {
    if (await checkInternet()) {
      ProgressDialog prg = customProgressDialog(context);
      prg.show();
      DioHelper.postData(url: APPOINTMENT_UPDATE, data: apnt.toJson())
          .then((value) {
        prg.hide();
        if (value.statusCode == 200) {
          print(value.data);
          if (value.data['status'] == 1) {
            List<AppointmentDetails> list = [];
            List<dynamic> vlist = value.data['appointments'];
            list = vlist
                .map(
                  (e) => AppointmentDetails.fromJson(e),
                )
                .toList();
            emit(AppointmentsSettingsSaved(appointmentDetails: list));
          } else {
            emit(AppointmentsSettingsError());
          }
        } else
          emit(AppointmentsSettingsError());
      }).catchError((error) {
        prg.hide();
        ErrorHandler.handleError(error, showToast: true);
        print(error);
        emit(AppointmentsSettingsError());
      });
    }
  }
}
