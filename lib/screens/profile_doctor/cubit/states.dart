part of 'cubit.dart';

abstract class ProfileDoctorStates {}

class ProfileDoctorInitial extends ProfileDoctorStates {}

class ProfileDoctorSaved extends ProfileDoctorStates {}

class ProfileDoctorError extends ProfileDoctorStates {}

class ProfileDoctorFailed extends ProfileDoctorStates {}

class ProfileDoctorChangeGenderState extends ProfileDoctorStates {}

class ProfileDoctorSetFileImageState extends ProfileDoctorStates {}

class ProfileDoctorSelectedSubCatState extends ProfileDoctorStates {}
