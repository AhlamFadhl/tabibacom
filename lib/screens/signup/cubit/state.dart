part of 'cubit.dart';

@immutable
abstract class SignUpStates {}

class SignUpInitial extends SignUpStates {}

class SignUpLoading extends SignUpStates {}

class SignUpSucsses extends SignUpStates {}

class SignUpFailed extends SignUpStates {}

class SignUpEmailFailed extends SignUpStates {}

class SignUpPhoneFailed extends SignUpStates {}

class SignUpError extends SignUpStates {}

class SignUpNextState extends SignUpStates {}

class SignUpFailedNextState extends SignUpStates {}

class SignUpLoadingCategoryState extends SignUpStates {}

class SignUpGetCategoryState extends SignUpStates {}

class SignUpErrorGetCategoryState extends SignUpStates {}

class SignUpSelectCatState extends SignUpStates {}
