import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:tabibacom_doctor/layout/schedule/cubit/cubit.dart';
import 'package:tabibacom_doctor/layout/schedule/schedule_page.dart';
import 'package:tabibacom_doctor/models/appointment_details_model.dart';
import 'package:tabibacom_doctor/models/book_model.dart';
import 'package:tabibacom_doctor/models/category_model.dart';
import 'package:tabibacom_doctor/models/doctor_model.dart';
import 'package:tabibacom_doctor/models/hospital_model.dart';
import 'package:tabibacom_doctor/screens/appointments_settings/appointments_settings_page.dart';
import 'package:tabibacom_doctor/screens/home/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/list_book_details/list_book_details_page.dart';
import 'package:tabibacom_doctor/screens/my_center_appointments/my_center_appointments.dart';
import 'package:tabibacom_doctor/screens/profile_doctor/profile_doctor_page.dart';
import 'package:tabibacom_doctor/screens/list_patients/list_patients_page.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_border.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_button_widget.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_shadow.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_image.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_progress_Indicator.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_sized_box.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/components/utils/functions.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';
import 'package:tabibacom_doctor/shared/styles/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget defultIconButton(
        {required Function() onPressed, required IconData icon}) =>
    IconButton(
        icon: CircleAvatar(
          radius: 35,
          backgroundColor: Colors.white.withOpacity(0.3),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        onPressed: onPressed);

Widget defaultCardSearch() => Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ابحث هنا',
            style: styleSupTitle,
          ),
          Icon(
            Icons.search,
            color: Colors.white,
          )
        ],
      ),
    );

Widget defaultBarcode() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Icon(Icons.code),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  Function()? onTap,
  bool isPassword = false,
  required FormFieldValidator validate,
  required String hinttxt,
  IconData? prefix,
  IconData? suffix,
  Function()? suffixPressed,
  bool isClickable = true,
  bool filled = false,
  int? maxline = 1,
}) =>
    TextFormField(
      maxLines: maxline,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        hintText: hinttxt,
        hintStyle: hintStyle,
        filled: filled,
        fillColor: textErrorColor,
        errorStyle: styleError,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: enableBorderTextFeild(),
        enabledBorder: enableBorderTextFeild(),
        focusedBorder: enableBorderFocusedTextFeild(),
        errorBorder: enableBorderErrorTextFeild(),
      ),
    );

OutlineInputBorder enableBorderErrorTextFeild() => OutlineInputBorder(
    gapPadding: 0,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      color: textErrorColor,
      width: 1,
    ));
OutlineInputBorder enableBorderTextFeild() => OutlineInputBorder(
    gapPadding: 0,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      color: textGrayColor,
      width: 1,
    ));
OutlineInputBorder enableBorderFocusedTextFeild() => OutlineInputBorder(
    gapPadding: 0,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      color: Colors.black,
      width: 1,
    ));

defaultTextField({
  required TextEditingController controller,
  TextInputType type = TextInputType.text,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  Function()? onTap,
  bool isPassword = false,
  required FormFieldValidator validate,
  required String hinttxt,
  IconData? prefix,
  IconData? suffix,
  Function()? suffixPressed,
  bool isClickable = true,
  bool filled = false,
  int? maxline = 1,
}) =>
    TextFormField(
      maxLines: maxline,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        hintText: hinttxt,
        hintStyle: hintStyle,
        filled: filled,
        fillColor: textErrorColor,
        errorStyle: styleError,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
      ),
    );

Widget buildCategoryItem(CategoryDoc cat, context) => Container(
      height: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(50.0),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: cat.cat_image,
              placeholder: (context, url) => Container(),
              errorWidget: (context, url, error) => Container(),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            width: 100,
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              cat.cat_name,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
Widget buildDoctorItem(Doctor doc, context) => InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CustomImage(
                    fit: BoxFit.cover,
                    url: PATH_IMAGES + doc.doc_image,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      topLeft: Radius.circular(5),
                    ),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Icon(
                    Icons.favorite,
                    size: 15,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 8.0,
            ),
            Container(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    doc.cat_name ?? '',
                    textAlign: TextAlign.start,
                    style: styleText_mini_colored,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'د/ ' + doc.doc_first_name + ' ' + doc.doc_last_name,
                    textAlign: TextAlign.start,
                    style: styleText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    doc.doc_specialist ?? '',
                    textAlign: TextAlign.start,
                    style: styleText_mini_gryed,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    doc.doc_price.toString(),
                    style: styleText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: CustomImage(
                          fit: BoxFit.cover,
                          url: doc.hsptl_logo ?? '',
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        doc.hsptl_name ?? '',
                        textAlign: TextAlign.start,
                        style: styleText.copyWith(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
Widget buidCardHospital(Hospital doc) => Row(
      children: [
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: CustomImage(
            fit: BoxFit.cover,
            url: PATH_IMAGES + (doc.hsptl_logo ?? ""),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          doc.hsptl_name,
          textAlign: TextAlign.start,
          style: styleText.copyWith(fontSize: 14),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
Widget buildHospitalItem(Hospital hsptl, context) => Container(
      height: 130,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(50.0),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CustomImage(
              fit: BoxFit.cover,
              url: PATH_IMAGES + (hsptl.hsptl_logo ?? ''),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            width: 100,
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              hsptl.hsptl_name,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );

Widget categoriesBuilder({
  required List<CategoryDoc> categories,
}) =>
    Container(
      height: 130,
      child: ConditionalBuilder(
        condition: categories.length > 0,
        builder: (context) => Container(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return buildCategoryItem(categories[index], context);
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 5,
            ),
            itemCount: categories.length,
          ),
        ),
        fallback: (context) => Container(),
      ),
    );

Widget hospitalsBuilder({
  required List<Hospital> hospitals,
}) =>
    Container(
      height: 130,
      child: ConditionalBuilder(
        condition: hospitals.length > 0,
        builder: (context) => Container(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return buildHospitalItem(hospitals[index], context);
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
            itemCount: hospitals.length,
          ),
        ),
        fallback: (context) => Container(),
      ),
    );

Widget doctorsBuilder({
  required List<Doctor> doctors,
}) =>
    Container(
      height: 120,
      child: ConditionalBuilder(
        condition: doctors.length > 0,
        builder: (context) => Container(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return buildDoctorItem(doctors[index], context);
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
            itemCount: doctors.length,
          ),
        ),
        fallback: (context) => Container(),
      ),
    );

Widget buildCurve({required Widget child, double height = 220}) => ClipPath(
    clipper: CurveClipper(),
    child: Container(
      padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(-1.0, -1.0),
              end: Alignment(-1.0, 1),
              colors: [
            secondColor,
            primaryColor,
          ])),
      child: child,
    ));

Widget myDivider({Color color = lightColor}) => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 0.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: color,
      ),
    );
Widget buildDoctorItem_Main(Doctor doc) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            // border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizedBox(
                height: 10,
              ),
              //image Profile
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: InkWell(
                  onTap: () {
                    Get.to(ProfileDoctor(
                      doctor: doc,
                    ));
                  },
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            profileImage(PATH_IMAGES + doc.doc_image),
                            /* InkWell(
                              onTap: () {
                                Get.to(ProfileDoctor(
                                  doctor: doc,
                                ));
                              },
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  margin: const EdgeInsets.all(5),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                  )),
                            ),
                         
                         */
                          ],
                        ),
                        CustomSizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(secondColor),
                                ),
                                onPressed: () {
                                  Get.to(ProfileDoctor(
                                    doctor: doc,
                                  ));
                                },
                                child: CustomText(
                                  'تعديل',
                                  color: textGrayColor,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                doc.cat_name ?? '',
                                textAlign: TextAlign.start,
                                style: styleText_mini_colored,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'د/ ' +
                                    doc.doc_first_name +
                                    ' ' +
                                    doc.doc_last_name,
                                textAlign: TextAlign.start,
                                style: styleText,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                doc.doc_specialist ?? '',
                                textAlign: TextAlign.start,
                                style: styleText_mini_gryed,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomSizedBox(
                height: 10,
              ),

              ///Rating
              Row(
                children: [
                  buildBlockNumber(
                    icon: Icons.star,
                    title: 'تقييم',
                    value: 0,
                    color: insideColor,
                    onTap: () {},
                  ),
                  Spacer(),
                  buildBlockNumber(
                    onTap: () {
                      Get.to(ListPatientsPage());
                    },
                    icon: Icons.people,
                    title: 'المرضى',
                    value: doc.patients == null ? 0 : doc.patients!.length,
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //Desc
              CustomShadow(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        'نبذه عنك',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomSizedBox(
                        height: 12,
                      ),
                      CustomText(
                        doc.doc_desc == "" ? 'لا يوجد نبذه عنك' : doc.doc_desc,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

Widget buildBlockNumber(
        {required title,
        required IconData icon,
        color = primaryColor,
        required value,
        required Function() onTap}) =>
    Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomShadow(
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
            ),
          ),
          CustomSizedBox(
            width: 10,
          ),
          Column(
            children: [
              CustomSizedBox(
                height: 5,
              ),
              CustomText(
                title,
                fontSize: 13,
                color: textGrayColor,
              ),
              CustomSizedBox(
                height: 5,
              ),
              CustomText(
                value.toString(),
                fontSize: 15,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );

Widget profileImage(String url) => Stack(
      alignment: Alignment.center,
      children: [
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              Container(
                  height: 165,
                  width: 165,
                  decoration: BoxDecoration(
                    color: insideColor,
                    shape: BoxShape.circle,
                  )),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  color: Colors.white,
                  width: 50,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
        Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            )),
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: CustomImage(
            url: url,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );

Widget buildHospitalCard(Hospital hospital, context) => CustomShadow(
      child: MaterialButton(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
        onPressed: () async {
          await Get.to(() => MyCenterAppointments(
                hsptl: hospital,
                isOwner: hospital.doc_owner == 1 ? true : false,
              ));
          HomeCubit.get(context).refresh_User();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              trailing: Icon(
                Icons.arrow_right_rounded,
                size: 40,
                color: Colors.grey.shade400,
              ),
              leading: Container(
                  width: 50,
                  height: 50,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: CustomImage(
                    url: PATH_IMAGES + hospital.hsptl_logo!,
                    fit: BoxFit.cover,
                  )),
              title: Text(hospital.doc_owner == 1
                  ? 'بيانات عيادتي'
                  : hospital.hsptl_name),
              subtitle:
                  hospital.doc_owner == 1 ? Text(hospital.hsptl_name) : null,
            ),
            if (hospital.appointments.length > 0)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: CustomButtonWidget(
                  title: 'ملخص المواعيد',
                  onTap: () {
                    Get.to(SchedulePage(
                      hospital: hospital,
                      doctor: user_doctor!.doctor!,
                    ));
                  },
                  color: Colors.grey.shade100,
                  textColor: textGrayColor,
                  height: 30,
                  width: 150,
                  textSize: 10,
                ),
              ),
            if (hospital.appointments.length == 0)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: CustomButtonWidget(
                  title: 'إضافة مواعيد',
                  onTap: () async {
                    List<AppointmentDetails>? list =
                        await Get.to(AppointmentsSettingsPage(
                      title: 'المواعيد في ' + hospital.hsptl_name,
                      hsptl: hospital,
                      appointmentDetails: [],
                    ));
                    if (list != null) {
                      hospital.appointments = list;
                      HomeCubit.get(context).setChange();
                    }
                  },
                  color: Colors.grey.shade100,
                  textColor: textGrayColor,
                  height: 30,
                  width: 150,
                  textSize: 10,
                ),
              ),
          ],
        ),
      ),
    );

Widget buildDoctorItem_Top(Doctor doc) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsetsDirectional.only(end: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: CustomImage(
                  fit: BoxFit.cover,
                  url: PATH_IMAGES + doc.doc_image,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Container(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        doc.cat_name ?? '',
                        textAlign: TextAlign.start,
                        style: styleText_mini_colored.copyWith(fontSize: 13),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'د/ ' + doc.doc_first_name + ' ' + doc.doc_last_name,
                        textAlign: TextAlign.start,
                        style: styleText.copyWith(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        doc.doc_specialist ?? '',
                        textAlign: TextAlign.start,
                        style: styleText_mini_gryed.copyWith(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Row(
          children: [
            Container(
              height: 60,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(0),
                ),
                border: Border.all(color: Colors.grey.shade300),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CustomImage(
                fit: BoxFit.cover,
                url: PATH_IMAGES + (doc.hsptl_logo ?? ''),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc.hsptl_name ?? '',
                  textAlign: TextAlign.start,
                  style: styleText_mini_colored.copyWith(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  doc.hsptl_address ?? '',
                  textAlign: TextAlign.start,
                  style: styleText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey.shade300,
        )
      ],
    );

Widget doctorsListBuilder({
  required List<Doctor> doctors,
}) =>
    ConditionalBuilder(
      condition: doctors.length > 0,
      builder: (context) => Container(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return buildDoctorItem_Main(doctors[index]);
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 10,
          ),
          itemCount: doctors.length,
        ),
      ),
      fallback: (context) => Container(),
    );

Widget buildItemBlackList() => InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              'xxxxxxxxxx xxxxxxx xxxxx xxxxxx',
              style: styleSupTitle,
            ),
          ],
        ),
      ),
    );

Widget buildItemNotification({required int index}) => InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: index % 2 != 0 ? Colors.grey.shade100 : Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 2),
                color: index % 2 != 0 ? lightColor : Colors.white,
                blurRadius: 3,
                spreadRadius: 1),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: lightColor,
              child: Image.asset('assets/images/alart.png'),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'تم اصدار العدد',
              style: styleSupTitle,
            ),
            Spacer(),
            Text(
              'منذ ٥ دقائق',
              style: styleSupTitle.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );

Widget buildItemsInformation(List<Widget> children) => InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 2),
                color: lightColor,
                blurRadius: 5,
                spreadRadius: 1),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );

buildTimeTable(List<AppointmentDetails> list) {
  return Column(
    children: [
      if (list.length >= 1) buidCardTime(list[0]),
      if (list.length >= 2) buidCardTime(list[1]),
      if (list.length >= 3) buidCardTime(list[2]),
      if (list.length >= 4) buidCardTime(list[3]),
      if (list.length >= 5) buidCardTime(list[4]),
      if (list.length >= 6) buidCardTime(list[5]),
      if (list.length >= 7) buidCardTime(list[6]),
    ],
  );
}

buidCardTime(AppointmentDetails apnt) => CustomBorder(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getDayName(apnt.apnt_day),
          ),
          Spacer(),
          if (!(apnt.apnt_avalible == 0))
            Text(
              DateFormat.jm().format(
                      DateTime.parse("2020-01-01 " + apnt.apnt_from_time)) +
                  ' - ',
            ),
          if (!(apnt.apnt_avalible == 0))
            Text(
              DateFormat.jm().format(
                      DateTime.parse("2020-01-01 " + apnt.apnt_to_time)) +
                  '  ',
            ),
          if (apnt.apnt_avalible == 0)
            Text(
              'غير متاح',
            ),
        ],
      ),
    );
String getDayName(int dayno) {
  if (dayno == 1)
    return 'السبت';
  else if (dayno == 2)
    return 'الأحد';
  else if (dayno == 3)
    return 'الأثنين';
  else if (dayno == 4)
    return 'الثلاثاء';
  else if (dayno == 5)
    return 'الأربعاء';
  else if (dayno == 6)
    return 'الخميس';
  else if (dayno == 7)
    return 'الجمعه';
  else
    return '';
}

buildProfileImage({
  required String url,
  double radius = 40,
}) =>
    CircleAvatar(
      radius: radius,
      backgroundColor: lightColor.withOpacity(0.3),
      child: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.5),
        radius: radius - 5,
        backgroundImage: NetworkImage(
          url,
        ),
        child: CircleAvatar(
          radius: radius - 10,
          backgroundColor: Colors.black45.withOpacity(0.1),
        ),
      ),
    );

buildCardInformationWedgit(title, Widget value,
        {required Function() onPressed, IconData icon = Icons.edit}) =>
    Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      title,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    IconButton(
                      onPressed: onPressed,
                      icon: Icon(icon),
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: value,
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );

buildCardInformationImage(title, url, {required Function() onPressed}) => Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      )),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomImage(
                url: url,
                height: 70,
              ),
            ),
            CustomSizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );

buildCardDateBook(
        BookModel bok, bool isHistory, Doctor doctor, Hospital hospital,
        {int? index, BuildContext? context}) =>
    CustomBorder(
      child: InkWell(
        onTap: () {
          Get.to(ListBookDetailsPage(
            doctor: doctor,
            hospital: hospital,
            currentDate: DateTime.parse(bok.book_date),
            recordCount: bok.book_count,
            isHestory: isHistory,
          ));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CustomShadow(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    Icons.date_range_outlined,
                    color: insideColor,
                  ),
                ),
              ),
              CustomSizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    getDayName(convertWeekDayNo(
                        DateTime.parse(bok.book_date).weekday)),
                    fontWeight: FontWeight.bold,
                  ),
                  CustomSizedBox(
                    height: 5,
                  ),
                  CustomText(
                      DateFormat.yMMMd().format(DateTime.parse(bok.book_date))),
                ],
              ),
              Spacer(),
              CircleAvatar(
                  backgroundColor: primaryColor,
                  child: Center(
                      child: CircleAvatar(
                          radius: 19,
                          backgroundColor: Colors.white,
                          child: CustomText(bok.book_count.toString())))),
              Spacer(),
              if (!isHistory)
                CircleAvatar(
                  backgroundColor: bok.holy_no == 0 ? lightColor : primaryColor,
                  child: IconButton(
                    icon: Icon(
                      Icons.airplanemode_on_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (index != null) {
                        ScheduleCubit.get(context)
                            .alertShowHoliday(index, bok.holy_no, context);
                      }
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );

buidItemBook(BookModel book, int i, context,
        {Function(String)? onSelected,
        bool isHistory = false,
        bool isNext = false}) =>
    Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(0, 2))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: getColorBookStatus(book.book_state),
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // DateFormat.yMMMEd().format(DateTime.parse(book.book_date)),
                  i.toString(),
                  style: styleText_w.copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  DateFormat.jm().format(
                      DateTime.parse(book.book_date + ' ' + book.book_time)),
                  style: styleText_w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                /*   Text(
                    'اسم صاحب الحجز : ',
                    style: styleText_mini_text,
                  ),*/
                Text(
                  book.pt_name,
                  textAlign: TextAlign.start,
                  style: styleText_mini_text,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                /* Text(
                    'رقم صاحب الحجز : ',
                    style: styleText_mini_text,
                  ),*/
                Text(
                  book.pt_phone,
                  textAlign: TextAlign.start,
                  style: styleText_mini_text,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.donut_large_sharp,
                          color: getColorBookStatus(book.book_state),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          getTitleBookStatus(book.book_state),
                          style: styleText_mini_colored.copyWith(
                              color: getColorBookStatus(book.book_state)),
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                if (!isHistory && !isNext)
                  PopupMenuButton(
                    onSelected: onSelected,
                    itemBuilder: (context) {
                      return {
                        'في الانتظار',
                        'في الداخل',
                        'طلب فحص',
                        'الغاء',
                        'الإنتهاء'
                      }.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(
                            choice,
                            style: styleText.copyWith(fontSize: 12),
                          ),
                        );
                      }).toList();
                    },
                  )
              ],
            ),
          ),
        ],
      ),
    );

customProgressDialog(context, {title}) => ProgressDialog(context,
    showLogs: true,
    isDismissible: false,
    customBody: Container(
      height: 80,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title ?? 'يتم الحفظ الأن ....'),
          CustomProgressIndicator(),
        ],
      ),
    ));

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
