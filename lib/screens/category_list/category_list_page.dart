import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tabibacom_doctor/models/category_model.dart';
import 'package:tabibacom_doctor/shared/components/custom_widgits/custom_image.dart';
import 'package:tabibacom_doctor/shared/network/end_points.dart';

class CategoryListPage extends StatelessWidget {
  List<CategoryDoc> list_category;
  CategoryListPage({required this.list_category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الأقسام'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildCategory(list_category[index]),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: list_category.length),
            ],
          ),
        ),
      ),
    );
  }

  buildCategory(CategoryDoc cat) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      color: Colors.grey.shade200,
                      offset: Offset(1, 1),
                      spreadRadius: 1,
                    )
                  ]),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: MaterialButton(
                child: ListTile(
                  leading: Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: CustomImage(
                        fit: BoxFit.cover,
                        url: '${PATH_IMAGES}${cat.cat_image}',
                      )),
                  title: Text(
                    cat.cat_name,
                  ),
                ),
                onPressed: () {
                  Get.back(result: cat);
                },
              ),
            ),
          ],
        ),
      );
}
