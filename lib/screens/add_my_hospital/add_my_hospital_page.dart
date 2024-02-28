import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/screens/add_my_hospital/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/add_my_hospital/hospital_images_page.dart';
import 'package:tabibacom_doctor/shared/components/components.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_button_widget.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_image.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class AddMyHospitalPage extends StatelessWidget {
  bool isEditing = false;
  Hospital? hospital;
  AddMyHospitalPage({super.key, this.isEditing = false, this.hospital});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddMyHospitalCubit()..setHospitalData(isEditing, hospital),
      child: BlocConsumer<AddMyHospitalCubit, AddMyHospitalState>(
        listener: (context, state) {
          if (state is AddMyHospitalSaved) {
            // Get.back(result: state.hospital);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AddMyHospitalCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('بيانات العياده'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: cubit.imageLogoHospital == null
                                ? CustomImage(
                                    url: hospital == null
                                        ? ''
                                        : PATH_IMAGES + hospital!.hsptl_logo!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    cubit.imageLogoHospital!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          //  if (isEditing)
                          IconButton(
                            onPressed: () async {
                              cubit.changeFileLogo(await pickImage(context));

                              /*    if (cubit.imageLogoHospital != null) {
                              if (await checkInternet()) {
                                  ProgressDialog prg =
                                      customProgressDialog(context);
                                  prg.show();
                                 var value =
                                      await cubit.updateImageLogoHospital(
                                          cubit.imageLogoHospital!, hospital!);
                                  prg.hide();
                                  if (value == 1) {
                                    showToast(
                                        text: 'تم حفظ الصوره',
                                        state: ToastStates.SUCCESS);
                                  } else {
                                    showToast(
                                        text: 'حدث خطأ بحفظ الصوره',
                                        state: ToastStates.ERROR);
                                  }
                                } else {
                                  cubit.changeFileLogo(null);
                                }
                              }*/
                            },
                            icon: CircleAvatar(
                              child: Icon(
                                Icons.add_a_photo_outlined,
                              ),
                            ),
                          )
                        ],
                      )),
                      CustomText('اسم العياده'),
                      SizedBox(
                        height: 8,
                      ),
                      defaultFormField(
                          controller: cubit.ControllerName,
                          type: TextInputType.text,
                          validate: (value) {},
                          hinttxt: 'اسم العياده'),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText('رقم العياده'),
                      SizedBox(
                        height: 8,
                      ),
                      defaultFormField(
                          controller: cubit.ControllerNo,
                          type: TextInputType.number,
                          validate: (value) {},
                          hinttxt: 'رقم العياده'),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText('عنوان العياده'),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.place_sharp,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  'في الخريطه',
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      defaultFormField(
                          controller: cubit.ControllerAddress,
                          type: TextInputType.text,
                          validate: (value) {},
                          hinttxt: 'عنوان العياده'),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText('سعر الكشف'),
                      SizedBox(
                        height: 8,
                      ),
                      defaultFormField(
                          controller: cubit.ControllerPrice,
                          type: TextInputType.number,
                          validate: (value) {},
                          hinttxt: 'سعر الكشف'),
                      /*  SizedBox(
                        height: 20,
                      ),
                      CustomText('سعر الاستشارة'),
                      SizedBox(
                        height: 8,
                      ),
                      defaultFormField(
                          controller: cubit.ControllerPrice,
                          type: TextInputType.number,
                          validate: (value) {},
                          hinttxt: 'سعر الاستشارة'),*/
                      SizedBox(
                        height: 20,
                      ),
                      /*  if (isEditing)
                        Row(
                          children: [
                            CustomText('صور العيادة'),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  if (hospital != null) {
                                    Get.to(HospitalImagesPage(
                                        hospital: hospital!));
                                  }
                                },
                                icon: Icon(Icons.add_a_photo))
                          ],
                        ),*/
                      if (hospital != null &&
                          hospital!.hsptl_images != null &&
                          hospital!.hsptl_images != '')
                        Row(
                          children: List.generate(
                              hospital!.hsptl_images!.split(',').length,
                              (index) => Container(
                                    child: Stack(
                                      children: [
                                        CustomImage(
                                            url: PATH_IMAGES +
                                                hospital!.hsptl_images!
                                                    .split(',')[index]),
                                      ],
                                    ),
                                  )),
                        ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButtonWidget(
                        onTap: () {
                          Hospital hsptl = Hospital(
                              hsptl_no: 0,
                              hsptl_name: cubit.ControllerName.text,
                              hsptl_date_joined: DateTime.now().toString(),
                              doc_price: cubit.ControllerPrice.text,
                              hsptl_phone_call: cubit.ControllerNo.text,
                              doc_owner: 1,
                              hsptl_address: cubit.ControllerAddress.text,
                              doc_no: user_doctor!.doctor!.doc_no,
                              doc_note: '',
                              hsptl_type: 0,
                              avg_time: 60,
                              appointments: [],
                              images: []);
                          if (!isEditing) {
                            cubit.saveHospitalData(
                              hsptl,
                            );
                          } else {
                            hsptl.hsptl_no = hospital!.hsptl_no;
                            cubit.updateHospitalData(hsptl,
                                imageFile: cubit.imageLogoHospital);
                          }
                        },
                        title: 'حفظ',
                        loading: cubit.isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
