part of 'cubit.dart';

@immutable
abstract class AddBookState {}

class AddBookInitial extends AddBookState {}

class AddBookSelectPatinet extends AddBookState {}

class AddBookSelectDate extends AddBookState {}

class AddBookSelectTime extends AddBookState {}

class AddBookAddNote extends AddBookState {}
