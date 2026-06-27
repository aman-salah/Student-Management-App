class StudentModel {
  final String name;
  final String studid;
  final int age;
  final String email;
  final String contact;

  StudentModel({
    required this.name,
    required this.studid,
    required this.age,
    required this.email,
    required this.contact,
  });
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json["name"],
      studid: json["studid"],
      age: json["age"],
      email: json["email"],
      contact: json["contact"],
    );
  }
}
