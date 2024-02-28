part of 'cubit.dart';

@immutable
abstract class AddMyHospitalState {}

class AddMyHospitalInitial extends AddMyHospitalState {}

class AddMyHospitalSaving extends AddMyHospitalState {}

class AddMyHospitalSaved extends AddMyHospitalState {
  Hospital? hospital;
  AddMyHospitalSaved(this.hospital);
}

class AddMyHospitalError extends AddMyHospitalState {}

class AddMyHospitalFailed extends AddMyHospitalState {}

class AddMyHospitalUpdated extends AddMyHospitalState {
  Hospital? hospital;
  AddMyHospitalUpdated(this.hospital);
}

class AddMyHospitalErrorUpdate extends AddMyHospitalState {}

class AddMyHospitalFailedUpdate extends AddMyHospitalState {}

class AddMyHospitalChangeFileLogo extends AddMyHospitalState {}

class AddMyHospitalUpdatedLogo extends AddMyHospitalState {
  String? logo;
  AddMyHospitalUpdatedLogo(this.logo);
}

class AddMyHospitalUpdatedLogoFailed extends AddMyHospitalState {}

class AddMyHospitalUpdatedLogoError extends AddMyHospitalState {}
