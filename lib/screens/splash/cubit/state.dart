part of 'cubit.dart';

abstract class SplashStates {}

class SplashInitial extends SplashStates {}

class SplashLoadingUserState extends SplashStates {}

class SplashErrorEnterUserState extends SplashStates {}

class SplashFailedEnterUserState extends SplashStates {}

class SplashSucessEnterUserState extends SplashStates {}

class SplashNotLoginState extends SplashStates {}

class SplashNoInternetState extends SplashStates {}
