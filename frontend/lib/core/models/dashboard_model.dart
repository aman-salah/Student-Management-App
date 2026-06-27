class DashboardModel {
  final int totalStudents;
  final int totalClasses;

  DashboardModel({required this.totalStudents, required this.totalClasses});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalStudents: json["total_students"],
      totalClasses: json["total_classes"],
    );
  }
}
