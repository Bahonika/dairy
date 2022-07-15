import 'package:dairy/utf_8_convert.dart';

class Aim {
  final int id;
  final String name;
  final int userId;
  final DateTime deadline;
  final bool isDone;

  Aim(
      {required this.id,
      required this.name,
      required this.deadline,
      required this.userId
      ,required this.isDone
      });

  String aimAlias = "Цель";

  factory Aim.fromJson(Map<String, dynamic> json) {
    return Aim(
        id: json["id"],
        name: utf8convert(json['name']),
        deadline: DateTime.parse(json["deadline"]),
        userId: json["user_id"],
        isDone: json["is_done"]
    );
  }
}
