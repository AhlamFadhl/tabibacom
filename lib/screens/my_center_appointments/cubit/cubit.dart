import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';

part 'states.dart';

class MyHospitalSettingsCubit extends Cubit<MyHospitalSettingsStates> {
  MyHospitalSettingsCubit({required this.hsptl})
      : super(MyHospitalSettingsInitial());
  static MyHospitalSettingsCubit get(context) => BlocProvider.of(context);

  Hospital hsptl;

  changeAppointmentsData(appointments) {
    hsptl.appointments = appointments;
    emit(MyHospitalSettingsUpdateData());
  }
}
