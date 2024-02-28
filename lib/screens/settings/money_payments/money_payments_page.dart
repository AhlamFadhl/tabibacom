import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_button_widget.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class MoneyPaymentsPage extends StatelessWidget {
  const MoneyPaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الفواتير'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 2),
                      color: Colors.grey.shade300,
                      spreadRadius: 1,
                      blurRadius: 2),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'إجمالي المبلغ المستحق',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomSizedBox(
                    height: 20,
                  ),
                  CustomText(
                    '0 ريال',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomSizedBox(
                    height: 10,
                  ),
                  CustomButtonWidget(
                    title: 'ادفع',
                    onTap: () {},
                    color: textGrayColor,
                  ),
                ],
              ),
            ),
            CustomSizedBox(
              height: 10,
            ),
            CustomText(
              'الفواتير',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            Expanded(
              child: ListView(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
