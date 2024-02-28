part of 'cubit.dart';

@immutable
abstract class PatientsState {}

class PatientsInitial extends PatientsState {}

class PatientsLoadingState extends PatientsState {}

class PatientsGetState extends PatientsState {}

class PatientsErrorState extends PatientsState {}

class PatientsSavingState extends PatientsState {}

class PatientsSavedState extends PatientsState {}

class PatientsErrorSaveState extends PatientsState {}

class PatientsFailedSaveState extends PatientsState {}

class PatientsChangeCardTypeState extends PatientsState {}

class PatientsChangeGenderState extends PatientsState {}

class PatientsChangeDateState extends PatientsState {}

class PatientsValidateFailedState extends PatientsState {}

class PatientsSetDataEditState extends PatientsState {}
