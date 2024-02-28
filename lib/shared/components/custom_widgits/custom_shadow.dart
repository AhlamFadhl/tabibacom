import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabibacom_doctor/shared/styles/colors.dart';

class CustomShadow extends StatelessWidget {
  final Widget child;
  final padding;
  final margin;
  final color;
  final double raduis;

  const CustomShadow({
    required this.child,
    this.padding,
    this.margin,
    this.color = Colors.white,
    this.raduis = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(0),
      padding: padding ?? const EdgeInsets.all(0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(raduis)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 5,
              color: Colors.grey.shade100.withOpacity(0.7))
        ],
      ),
      child: child,
    );
  }
}
