import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tabibacom_doctor/screens/settings/my_account/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/signin/signin_page.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/styles/styles.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAccountCubit(user: user_doctor!),
      child: BlocConsumer<MyAccountCubit, MyAccountStates>(
        listener: (context, state) {
          if (state is MyAccountDeleted) {
            Get.offAll(SignInPage());
          }
        },
        builder: (context, state) {
          var cubit = MyAccountCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('حسابي'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                buildCardInformationWedgit(
                    'البريد الإلكتروني',
                    CustomText(
                      cubit.user.usr_email,
                    ), onPressed: () {
                  cubit.showPopupEmail(context);
                }),
                SizedBox(
                  height: 8,
                ),
                buildCardInformationWedgit(
                    'رقم الجوال',
                    CustomText(
                      cubit.user.usr_phone,
                    ), onPressed: () {
                  cubit.showPopupPhone(context);
                }),
                SizedBox(
                  height: 8,
                ),
                buildCardInformationWedgit(
                    'تغيير كلمة السر',
                    CustomText(
                      '********',
                    ), onPressed: () {
                  cubit.showPopupPass(context);
                }),
                Spacer(),
                Container(
                  height: 60,
                  child: MaterialButton(
                    onPressed: () {
                      cubit.alertShowDelete(cubit.user, context);
                    },
                    child: Center(
                        child: Text(
                      'حذف الحساب',
                      style: styleError.copyWith(fontSize: 18),
                    )),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
