import 'package:get/get.dart';

class Validation {
  static String? fieldValidate(val) {
    return val!.isEmpty ? 'This Field is required'.tr : null;
  }

  static String? nameValidate(val) {
    return val!.isEmpty ? 'Name is required'.tr : null;
  }

  static String? firstnameValidate(val) {
    return val!.isEmpty ? 'ادخل اسمك الأول'.tr : null;
  }

  static String? lastnameValidate(val) {
    return val!.isEmpty ? 'اكتب اسمك الأخير'.tr : null;
  }

  static String? phoneValidate(val) {
    return val!.isEmpty ? 'اكتب رقم الجوال'.tr : null;
  }

  static String? descrptionValidate(val) {
    return val!.isEmpty ? 'اكتب وصف عن الطبيب'.tr : null;
  }

  static String? categoryValidate(val) {
    return val!.isEmpty ? 'اختر التخصص'.tr : null;
  }

  static String? emailValidate(val) {
    return val!.isEmpty
        ? 'اكتب البريد الإلكتروني'.tr
        : !GetUtils.isEmail(val)
            ? "البريد الإلكتروني غير صالح".tr
            : null;
  }

  static String? passwordValidate(val) {
    return val!.isEmpty ? 'اكتب كلمة السر'.tr : null;
  }

  static String? patientnameValidate(val) {
    return val!.isEmpty ? 'اكتب اسم المريض'.tr : null;
  }

  static String? patientnoValidate(val) {
    return val!.isEmpty ? 'اكتب رقم المريض'.tr : null;
  }

  static String? noValdation(val) {
    return null;
  }
}
