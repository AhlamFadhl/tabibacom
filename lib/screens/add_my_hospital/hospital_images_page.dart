import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/screens/add_my_hospital/cubit/cubit.dart';

class HospitalImagesPage extends StatelessWidget {
  bool isEditing = true;
  Hospital hospital;
  HospitalImagesPage(
      {super.key, this.isEditing = true, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
