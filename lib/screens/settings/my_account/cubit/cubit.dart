import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:tabibacom_doctor/models/users_model.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_alret_dialog.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text_field.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/components/utils/validation.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/network/remote/dio_helper.dart';

part 'states.dart';

class MyAccountCubit extends Cubit<MyAccountStates> {
  MyAccountCubit({required this.user}) : super(MyAccountInitial());
  static MyAccountCubit get(context) => BlocProvider.of(context);
  Users user;
  deleteUser(Users usr) async {
    emit(MyAccountLoadingDelete());
    try {
      var value = await DioHelper.postData(url: USERDELETE, data: usr.toJson());
      if (value.data["status"] == 1) {
        signOut();
        emit(MyAccountDeleted());
      } else {
        emit(MyAccountFailedDelete());
      }
    } catch (error) {
      print(error);
      emit(MyAccountErrorDelete());
    }
  }

  alertShowDelete(Users usr, context) async {
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: 'حذف حساب',
        question: 'هل أنت متأكد من حذف حسابك؟',
      ),
    );

    if (result != null && result) {
      // User clicked "Yes"
      if (await checkInternet()) {
        ProgressDialog prg =
            customProgressDialog(context, title: 'يتم حذف الحساب الأن ....');
        prg.show();
        await deleteUser(usr);
        prg.hide();
      }
    } else {
      // User clicked "No" or dialog was dismissed
    }
  }

  updateUserEmail(Users usr, email) async {
    emit(MyAccountLoadingUpdated());
    try {
      usr.usr_email = email;
      var value =
          await DioHelper.postData(url: USERUPDATEEMAIL, data: usr.toJson());
      if (value.data["status"] == 1) {
        user.usr_email = email;
        if (user_doctor != null) user_doctor!.usr_email = email;
        emit(MyAccountUpdated());
      } else {
        emit(MyAccountFailedUpdate());
      }
      return value.data["status"];
    } catch (error) {
      print(error);
      emit(MyAccountErrorUpdate());
      return 0;
    }
  }

  updateUserPhone(Users usr, phone) async {
    emit(MyAccountLoadingUpdated());
    try {
      user.usr_phone = phone;
      var value =
          await DioHelper.postData(url: USERUPDATEPHONE, data: usr.toJson());
      if (value.data["status"] == 1) {
        user.usr_phone = phone;
        if (user_doctor != null) user_doctor!.usr_phone = phone;
        emit(MyAccountUpdated());
      } else {
        emit(MyAccountFailedUpdate());
      }
      return value.data["status"];
    } catch (error) {
      print(error);
      emit(MyAccountErrorUpdate());
      return 0;
    }
  }

  updateUserPassword(Users usr, pass_new, pass_old) async {
    emit(MyAccountLoadingUpdated());
    try {
      var value = await DioHelper.postData(url: USERUPDATEPASS, data: {
        'usr_no': usr.usr_no,
        'usr_pass': pass_new,
        'usr_pass_old': pass_old
      });
      if (value.data["status"] == 1) {
        emit(MyAccountUpdated());
      } else {
        emit(MyAccountFailedUpdate());
      }
      return value.data["status"];
    } catch (error) {
      print(error);
      emit(MyAccountErrorUpdate());
    }
    return 0;
  }

  void showPopupEmail(BuildContext context) async {
    var controllerEmail = TextEditingController(text: user.usr_email);
    var formKey = GlobalKey<FormState>();
    var result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: CustomText(
            'البريد الإلكتروني',
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: controllerEmail,
                  hintText: 'البريد الإلكتروني',
                  validator: (value) => Validation.emailValidate(value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Close the dialog
              },
              child: Text('اغلاق'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(context).pop(true);
                }
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
    if (result != null && result) {
      if (formKey.currentState!.validate()) {
        if (await checkInternet()) {
          ProgressDialog prg = customProgressDialog(context);
          prg.show();
          var value = await updateUserEmail(user, controllerEmail.text);
          prg.hide();
          if (value == 1) {
            showToast(text: 'تم الحفظ', state: ToastStates.SUCCESS);
          } else
            showToast(text: 'حدث خطأ اثناء الحفظ', state: ToastStates.ERROR);
        }
      }
    }
  }

  void showPopupPhone(BuildContext context) async {
    var controllerPhone = TextEditingController(text: user.usr_phone);
    var formKey = GlobalKey<FormState>();
    var result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: CustomText(
            'رقم الجوال',
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: controllerPhone,
                  hintText: 'رقم الجوال',
                  keyboardType: TextInputType.phone,
                  validator: (value) => Validation.phoneValidate(value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Close the dialog
              },
              child: Text('اغلاق'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(context).pop(true);
                }
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
    if (result != null && result) {
      if (formKey.currentState!.validate()) {
        if (await checkInternet()) {
          ProgressDialog prg = customProgressDialog(context);
          prg.show();
          var value = await updateUserPhone(user, controllerPhone.text);
          prg.hide();
          if (value == 1) {
            showToast(text: 'تم الحفظ', state: ToastStates.SUCCESS);
          } else
            showToast(text: 'حدث خطأ اثناء الحفظ', state: ToastStates.ERROR);
        }
      }
    }
  }

  void showPopupPass(BuildContext context) async {
    var controllerCurrentPass = TextEditingController();
    var controllerNewPass = TextEditingController();
    var controllerReNewPass = TextEditingController();

    var formKey = GlobalKey<FormState>();
    var result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: CustomText(
            'تغيير كلمة السر',
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: controllerCurrentPass,
                  hintText: 'كلمة السر الحالية',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) => Validation.passwordValidate(value),
                ),
                CustomSizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: controllerNewPass,
                  hintText: 'كلمة السر الجديدة',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) => Validation.passwordValidate(value),
                ),
                CustomSizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: controllerReNewPass,
                  hintText: 'إعادة كلمة السر الجديدة',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) => Validation.passwordValidate(value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Close the dialog
              },
              child: Text('اغلاق'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (controllerNewPass.text == controllerReNewPass.text) {
                    Navigator.of(context).pop(true);
                  } else {
                    showToast(
                        text: 'كلمه السر غير متطابقه',
                        state: ToastStates.ERROR);
                  }
                }
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
    if (result != null && result) {
      if (formKey.currentState!.validate()) {
        if (controllerNewPass.text == controllerReNewPass.text) {
          if (await checkInternet()) {
            ProgressDialog prg = customProgressDialog(context);
            prg.show();
            var value = await updateUserPassword(
                user, controllerNewPass.text, controllerCurrentPass.text);
            prg.hide();
            if (value == 1) {
              showToast(text: 'تم الحفظ', state: ToastStates.SUCCESS);
            } else {
              showToast(text: 'حدث خطأ اثناء الحفظ', state: ToastStates.ERROR);
            }
          }
        } else {
          showToast(text: 'كلمه السر غير متطابقه', state: ToastStates.ERROR);
        }
      }
    }
  }
}
