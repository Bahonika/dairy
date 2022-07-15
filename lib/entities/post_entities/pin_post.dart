import 'package:dairy/entities/abstract/postable.dart';
import 'package:dairy/utf_8_convert.dart';

class PinPost implements Postable {
  final String name;
  final String image;
  final double x;
  final double y;

  PinPost({
    required this.x,
    required this.y,
    required this.name,
    required this.image,
  });

  @override
  Map<String, dynamic> toJson() {
    var map = {
      "name": name,
      "image": image,
      "x": x,
      "y": y,
    };

    return map;
  }


}
