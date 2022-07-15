import 'package:dairy/utf_8_convert.dart';

class Pin {
  final int id;
  final String name;
  final String image;
  final double x;
  final double y;

  Pin({
    required this.x,
    required this.y,
    required this.name,
    required this.id,
    required this.image,
  });

  factory Pin.fromJson(Map<String, dynamic> json) {
    return Pin(
        x: json["x"],
        y: json["y"],
        id: json["id"],
        image: json["image"],
        name: utf8convert(json["name"]));
  }
}
