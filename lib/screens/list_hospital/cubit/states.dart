part of 'cubit.dart';

@immutable
abstract class ListHospitalState {}

class ListHospitalInitial extends ListHospitalState {}

class ListHospitalLoadingState extends ListHospitalState {}

class ListHospitalGetState extends ListHospitalState {}

class ListHospitalErrorState extends ListHospitalState {}

class ListHospitalSelectLoadingState extends ListHospitalState {}

class ListHospitalSelectedState extends ListHospitalState {}
