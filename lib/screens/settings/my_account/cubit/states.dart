part of 'cubit.dart';

abstract class MyAccountStates {}

class MyAccountInitial extends MyAccountStates {}

class MyAccountLoadingDelete extends MyAccountStates {}

class MyAccountDeleted extends MyAccountStates {}

class MyAccountErrorDelete extends MyAccountStates {}

class MyAccountFailedDelete extends MyAccountStates {}

class MyAccountLoadingUpdated extends MyAccountStates {}

class MyAccountUpdated extends MyAccountStates {}

class MyAccountErrorUpdate extends MyAccountStates {}

class MyAccountFailedUpdate extends MyAccountStates {}
