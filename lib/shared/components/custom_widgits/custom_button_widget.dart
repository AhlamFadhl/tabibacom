import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool loading;
  final Color? color;
  final Color textColor;
  final double padding;
  final double height;
  final double width;
  final double? widthBorder;
  final double elevation;
  final double radius;
  final double textSize;
  final FontWeight? fontWeight;
  final Widget? icon;

  const CustomButtonWidget(
      {required this.title,
      required this.onTap,
      this.loading = false,
      this.color = primaryColor,
      this.fontWeight,
      this.textColor = Colors.white,
      this.width = double.infinity,
      this.widthBorder,
      this.height = 46,
      this.textSize = 16,
      this.radius = 10,
      this.elevation = 0,
      this.padding = 0,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height.h,
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: elevation,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
              side: widthBorder == null
                  ? BorderSide.none
                  : BorderSide(color: textColor, width: widthBorder!),
              borderRadius: BorderRadius.circular(radius)),
        ),
        onPressed: loading ? null : onTap,
        child: loading != null && loading == true
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade100))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    title,
                    fontSize: textSize,
                    textAlign: TextAlign.center,
                    color: textColor,
                    fontWeight: fontWeight,
                  ),
                  icon ?? Container()
                ],
              ),
      ),
    );
  }
}
