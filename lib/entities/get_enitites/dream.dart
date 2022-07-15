import 'package:dairy/utf_8_convert.dart';

class Dream {
  final int id;
  final String name;
  Dream({required this.name, required this.id});

  String dreamAlias = "Мечта";

  factory Dream.fromJson(Map<String, dynamic> json) {
    return Dream(name: utf8convert(json['name']), id: json["id"]);
  }
}
