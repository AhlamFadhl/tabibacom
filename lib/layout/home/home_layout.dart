import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tabibacom_doctor/layout/home/cubit/cubit.dart';
import 'package:tabibacom_doctor/layout/home/cubit/states.dart';
import 'package:tabibacom_doctor/shared/components/constants.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..changeIndex(0)
        ..getBookAppoientmens(
          user_doctor!.doctor!.doc_no,
          DateFormat('yyyy-MM-dd').format(DateTime.now().add(
            Duration(days: -2),
          )),
          DateFormat('yyyy-MM-dd').format(DateTime.now()),
        )
        ..getHospitalDataToday(DateTime.now(), user_doctor!.doctor!.doc_no),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            /*  appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
              actions: [
                if (cubit.currentIndex == 1)
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle_outline_sharp,
                        size: 30,
                      ))
              ],
            ),*/
            body: SafeArea(child: cubit.screens[cubit.currentIndex]),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: cubit.titles[0],
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list_outlined,
                  ),
                  label: cubit.titles[1],
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: cubit.titles[2],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
