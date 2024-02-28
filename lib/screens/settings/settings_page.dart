import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:tabibacom_doctor/screens/settings/about_us/about_us_page.dart';
import 'package:tabibacom_doctor/screens/list_patients/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/list_patients/list_patients_page.dart';
import 'package:tabibacom_doctor/screens/settings/money_payments/money_payments_page.dart';
import 'package:tabibacom_doctor/screens/settings/my_account/my_account_page.dart';
import 'package:tabibacom_doctor/screens/signin/signin_page.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_alret_dialog.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        //  color: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, top: 20),
              child: CustomText(
                'الإعدادات',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Get.to(MyAccountPage());
                },
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle_outlined,
                    color: primaryColor,
                  ),
                  title: Text('حسابي'),
                  trailing: Icon(Icons.arrow_right_sharp),
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            InkWell(
              onTap: () {
                Get.to(MoneyPaymentsPage());
              },
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.monetization_on,
                    color: primaryColor,
                  ),
                  title: Text('الفوتير'),
                  trailing: Icon(Icons.arrow_right_sharp),
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            InkWell(
              onTap: () {
                Get.to(ListPatientsPage());
              },
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.list_rounded,
                    color: primaryColor,
                  ),
                  title: Text('قائمة المرضى'),
                  trailing: Icon(Icons.arrow_right_sharp),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.to(AboutUsPage());
              },
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.support_agent_outlined,
                    color: primaryColor,
                  ),
                  title: Text('مساعدة'),
                  trailing: Icon(Icons.arrow_right_sharp),
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            /*  InkWell(
              onTap: () {},
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: primaryColor,
                  ),
                  title: Text('إعدادات'),
                  trailing: Icon(Icons.arrow_right_sharp),
                ),
              ),
            ),*/
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            InkWell(
              onTap: () async {
                bool result = await showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomAlertDialog(
                    title: 'تسجيل خروج',
                    question: 'هل أنت متأكد من تسجيل الخروج؟',
                  ),
                );

                if (result != null && result) {
                  // User clicked "Yes"
                  ProgressDialog prg = customProgressDialog(context,
                      title: 'يتم تسجيل الخروج الأن ....');
                  prg.show();
                  await signOut();
                  Get.offAll(SignInPage());
                  prg.hide();
                } else {
                  // User clicked "No" or dialog was dismissed
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.red.shade300,
                  ),
                  title: Text('تسجيل خروج'),
                  trailing: Icon(Icons.arrow_right_sharp),
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
