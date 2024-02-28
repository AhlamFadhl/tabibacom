import 'package:tabibacom_doctor/models/doctor_model.dart';

class CategoryDoc {
  int cat_no;
  String cat_name;
  String cat_image;

  CategoryDoc({
    required this.cat_no,
    required this.cat_name,
    required this.cat_image,
  });

  factory CategoryDoc.fromJson(Map<String, dynamic> json) {
    return CategoryDoc(
      cat_no: json['cat_no'],
      cat_name: json['cat_name'],
      cat_image: json['cat_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cat_no': cat_no,
      'cat_name': cat_name,
      'cat_image': cat_image,
    };
  }
}
