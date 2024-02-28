import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class CustomSizedBox extends StatelessWidget {
  final double? height;
  final double? width;

  const CustomSizedBox({this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.h,
      width: width?.w,
    );
  }
}
