import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:tabibacom_doctor/screens/profile_doctor/cubit/cubit.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_button_widget.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_image.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';

class AddImagePage extends StatelessWidget {
  const AddImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileDoctorCubit, ProfileDoctorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProfileDoctorCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'إضافة صوره',
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  cubit.imageLicenceFile = await pickImage(context);
                  if (cubit.imageLicenceFile != null) {
                    if (await checkInternet()) {
                      ProgressDialog prg = customProgressDialog(context);
                      prg.show();
                      var value = await cubit
                          .updateImageLiceneDoctor(cubit.imageLicenceFile!);
                      prg.hide();
                      if (value == 1) {
                        Get.back(result: cubit.doctor!.doc_license_img);
                        showToast(
                            text: 'تم حفظ الصوره', state: ToastStates.SUCCESS);
                      } else {
                        showToast(
                            text: 'حدث خطأ بحفظ الصوره',
                            state: ToastStates.ERROR);
                      }
                    } else {
                      cubit.imageLicenceFile = null;
                    }
                  }
                },
                icon: Icon(Icons.add_circle_outline_outlined),
              ),
            ],
          ),
          body: Container(
            child: cubit.imageLicenceFile != null
                ? Column(
                    children: [
                      Image.file(cubit.imageLicenceFile!),
                      CustomSizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : Center(
                    child: CustomImage(
                      url: PATH_IMAGES +
                          cubit.doctor!.doc_license_img.toString(),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
