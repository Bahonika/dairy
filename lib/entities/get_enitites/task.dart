import 'package:dairy/utf_8_convert.dart';

class Task {
  final int id;
  final String name;
  final DateTime deadline;
  final String status;
  final int userId;
  final int aimId;

  static const String todo = "ToDo";
  static const String inProgress = "In Progress";
  static const String done = "Done";

  Task(
      {required this.id,
      required this.aimId,
      required this.name,
      required this.status,
      required this.deadline,
      required this.userId});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json["id"],
        name: utf8convert(json['name']),
        deadline: DateTime.parse(json["deadline"]),
        status: utf8convert(json['status']),
        aimId: json["aim_id"],
        userId: json["user_id"]);
  }
}
