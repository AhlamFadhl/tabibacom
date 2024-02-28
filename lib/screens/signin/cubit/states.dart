part of 'cubit.dart';

@immutable
abstract class SigninStates {}

class SigninInitial extends SigninStates {}

class SigninLoading extends SigninStates {}

class SigninSucsses extends SigninStates {}

class SigninFailed extends SigninStates {}

class SigninError extends SigninStates {}
