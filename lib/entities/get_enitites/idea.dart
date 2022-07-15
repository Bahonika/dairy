import 'package:dairy/utf_8_convert.dart';

class Idea {
  final int id;
  final String name;
  Idea({required this.name, required this.id});

  String IdeaAlias = "Идея";

  factory Idea.fromJson(Map<String, dynamic> json) {
    return Idea(name: utf8convert(json['name']), id: json["id"]);
  }
}
