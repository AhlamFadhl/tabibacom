class HospitalTypes {
  int hstype_no;
  String hstype_name;
  String hstype_image;

  HospitalTypes({
    required this.hstype_no,
    required this.hstype_name,
    required this.hstype_image,
  });

  factory HospitalTypes.fromJson(Map<String, dynamic> json) {
    return HospitalTypes(
      hstype_no: json['hstype_no'],
      hstype_name: json['hstype_name'],
      hstype_image: json['hstype_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hstype_no': hstype_no,
      'hstype_name': hstype_name,
      'hstype_image': hstype_image,
    };
  }
}
// 1 عيادة
// 2 مركز
// 3 مستوصف
// 3 مستشفى 
