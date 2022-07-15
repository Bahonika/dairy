import 'package:dairy/utf_8_convert.dart';

class Post {
  final int id;
  final String name;
  final String body;
  final List<int> themes;

  Post(
      {required this.id,
        required this.name,
        required this.body,
        required this.themes});

  String aimAlias = "Запись";

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json["id"],
        name: utf8convert(json['name']),
        body: utf8convert(json["body"]),
        themes: json["themes"]);
  }
}
