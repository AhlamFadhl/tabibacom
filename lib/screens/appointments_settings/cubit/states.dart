// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cubit.dart';

abstract class AppointmentsSettingsStates {}

class AppointmentsSettingsInitial extends AppointmentsSettingsStates {}

class AppointmentsSettingsChangeType extends AppointmentsSettingsStates {}

class AppointmentsSettingsChangeAttendWay extends AppointmentsSettingsStates {}

class AppointmentsSettingsChangeCheck extends AppointmentsSettingsStates {}

class AppointmentsSettingsChangePeriod extends AppointmentsSettingsStates {}

class AppointmentsSettingsChangeCount extends AppointmentsSettingsStates {}

class AppointmentsSettingsSaved extends AppointmentsSettingsStates {
  List<AppointmentDetails> appointmentDetails;
  AppointmentsSettingsSaved({
    required this.appointmentDetails,
  });
}

class AppointmentsSettingsError extends AppointmentsSettingsStates {}
