class ClassesModel {
  final int class_id;
  final String subject;
  final String class_name;
  final int semester;

  ClassesModel({
    required this.class_id,
    required this.subject,
    required this.class_name,
    required this.semester,
  });

  factory ClassesModel.fromJson(Map<String, dynamic> json) {
    return ClassesModel(
      class_id: json["id"],
      subject: json["subject"],
      class_name: json["classname"],
      semester: json["semester"],
    );
  }
}
