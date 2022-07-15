import 'package:dairy/utf_8_convert.dart';

class ThemeEntity {
  final int id;
  final String name;

  ThemeEntity({
    required this.id,
    required this.name,
  });

  factory ThemeEntity.fromJson(Map<String, dynamic> json) {
    return ThemeEntity(
      id: json["id"],
      name: utf8convert(json['name']),
    );
  }
}
