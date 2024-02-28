part of 'cubit.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoadingHistoryState extends ScheduleState {}

class ScheduleGetHistoryState extends ScheduleState {}

class ScheduleErrorHistoryState extends ScheduleState {}

class ScheduleLoadingNextState extends ScheduleState {}

class ScheduleGetNextState extends ScheduleState {}

class ScheduleErrorNextState extends ScheduleState {}

class ScheduleLoadingMoreNextState extends ScheduleState {}

class ScheduleGetMoreNextState extends ScheduleState {}

class ScheduleErrorMoreNextState extends ScheduleState {}

class ScheduleLoadingHolyState extends ScheduleState {}

class ScheduleDoneHolyState extends ScheduleState {}

class ScheduleErrorHolyState extends ScheduleState {}
