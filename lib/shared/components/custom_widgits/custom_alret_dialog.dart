import 'package:flutter/material.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String question;
  CustomAlertDialog({required this.title, required this.question});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(question),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: lightColor),
          onPressed: () {
            Navigator.of(context).pop(false); // No
          },
          child: Text('لا'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Yes
          },
          child: Text('نعم'),
        ),
      ],
    );
  }
}
