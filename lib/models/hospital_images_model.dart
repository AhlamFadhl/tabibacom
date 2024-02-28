class HospitalImages {
  int id;
  int hsptl_no;
  String hsptl_img;
  String hsptl_date_enter;

  HospitalImages({
    required this.id,
    required this.hsptl_no,
    required this.hsptl_img,
    required this.hsptl_date_enter,
  });

  factory HospitalImages.fromJson(Map<String, dynamic> json) {
    return HospitalImages(
      id: json['id'],
      hsptl_no: json['hsptl_no'],
      hsptl_img: json['hsptl_img'],
      hsptl_date_enter: json['hsptl_date_enter'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hsptl_no': hsptl_no,
      'hsptl_img': hsptl_img,
      'hsptl_date_enter': hsptl_date_enter,
    };
  }
}
