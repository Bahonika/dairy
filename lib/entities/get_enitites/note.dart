import 'package:dairy/utf_8_convert.dart';

class Note {
  final String name;
  final int id;
  Note( {required this.name, required this.id,});

  String noteAlias = "Заметка";

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(name: utf8convert(json['name']), id: json["id"]);
  }
}
