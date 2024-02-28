import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibacom_doctor/screens/profile_doctor/cubit/cubit.dart';
import 'package:tabibacom_doctor/screens/profile_doctor/profile_doctor_page.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_text.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

class SubCategoriesListPage extends StatefulWidget {
  const SubCategoriesListPage({super.key});

  @override
  State<SubCategoriesListPage> createState() => _SubCategoriesListPageState();
}

class _SubCategoriesListPageState extends State<SubCategoriesListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileDoctorCubit, ProfileDoctorStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ProfileDoctorCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('التخصصات الفرعيه'),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: List.generate(cubit.subcategories.length, (index) {
                return InkWell(
                    onTap: () {
                      cubit.selectnuselectSubcategory(index);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: cubit.subcategories[index].selected
                              ? primaryColor
                              : Colors.grey.shade200,
                        ),
                        child:
                            CustomText(cubit.subcategories[index].sub_title)));
              }),
            ),
          ),
        );
      },
    );
  }
}
