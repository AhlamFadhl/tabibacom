import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';

class ErrorHandler {
  static Future<bool> handleError(
    Object e, {
    bool? showToast,
    dynamic? s,
  }) async {
    // log(s.toString());

    if (e is DioException) {
      log((e.response?.statusCode ?? 0).toString());
      log(e.response.toString());
      log(e.requestOptions.path);
      if (e.type == DioExceptionType.connectionTimeout) {
        final ConnectivityResult result =
            await Connectivity().checkConnectivity();
        if (result == ConnectivityResult.none) {
          showMessage('يرجى التأكد من اتصالك بالإنترنت'.tr, 2);
          return false;
        } else {
          showMessage('حدث خطأ!'.tr, 2);
          return false;
        }
      }
      if (e.type == DioExceptionType.connectionError) {
        final ConnectivityResult result =
            await Connectivity().checkConnectivity();
        if (result == ConnectivityResult.none) {
          showMessage('يرجى التأكد من اتصالك بالإنترنت'.tr, 2);
          return false;
        } else {
          showMessage('يرجى التأكد من اتصالك بالإنترنت'.tr, 2);
          return false;
        }
      }
      if (e.response != null && showToast == null) {
        if (e.response?.data['message'] is String) {
          if (e.response?.data['message']
                  .toString()
                  .contains('Unauthenticated') ==
              true) {
            // HiveController.setToken(null);
            return true;
          }
          showMessage(e.response?.data['message'].toString(), 2);
        } else {
          Map? map = e.response?.data['message'];
          StringBuffer errors = StringBuffer();
          map?.forEach((key, value) {
            if (value is List) {
              for (var element in value) {
                errors.write(element);
                errors.write('\n');
              }
            }
            errors.toString().substring(0, errors.toString().length - 3);
          });
          showMessage(errors.toString(), 2);
        }
      } else {
        final ConnectivityResult result =
            await Connectivity().checkConnectivity();
        if (result == ConnectivityResult.none) {
          showMessage('يرجى التأكد من اتصالك بالإنترنت'.tr, 2);
          return false;
        } else {
          //  showMessage('حدث خطأ'.tr, 2);
          return false;
        }
      }
      return true;
    } else {
      log("ErrorHandler else ==> " + e.toString());

      return true;
    }
  }
}
