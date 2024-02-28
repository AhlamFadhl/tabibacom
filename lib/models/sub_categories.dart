class SubCategories {
  int id;
  int cat_no;
  int sub_no;
  String sub_title;

  bool selected;
  int doc_no;

  SubCategories({
    required this.id,
    required this.cat_no,
    required this.sub_no,
    required this.sub_title,
    this.selected = false,
    required this.doc_no,
  });

  factory SubCategories.fromJson(Map<String, dynamic> json) {
    return SubCategories(
      id: json['id'],
      cat_no: json['cat_no'],
      sub_no: json['sub_no'],
      sub_title: json['sub_title'],
      selected: json.containsKey('selected') ? (json['selected'] != 0) : false,
      doc_no: json['doc_no'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cat_no': cat_no,
      'sub_no': sub_no,
      'sub_title': sub_title,
      'selected': selected,
      'doc_no': doc_no,
    };
  }
}
