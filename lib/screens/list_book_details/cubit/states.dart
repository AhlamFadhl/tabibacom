part of 'cubit.dart';

abstract class BookDetailsState {}

class BookDetailsInitial extends BookDetailsState {}

class BookDetailsLoadingState extends BookDetailsState {}

class BookDetailsGetState extends BookDetailsState {}

class BookDetailsErrorState extends BookDetailsState {}

class BookDetailsNoEnternetState extends BookDetailsState {}
