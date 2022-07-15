import 'package:dairy/entities/get_enitites/pin.dart';
import 'package:dairy/utf_8_convert.dart';

class Memory {
  final int id;
  final int userId;
  final String name;
  final int aimId;
  final List<Pin> pins;

  Memory(
      {required this.name,
      required this.userId,
      required this.id,
      required this.pins,
      required this.aimId});

  factory Memory.fromJson(Map<String, dynamic> json) {
    List<Pin> pins = <Pin>[];
    for (Map<String, dynamic> pin in json["pins"]) {
      pins.add(Pin(
          x: pin["x"],
          y: pin["y"],
          name: utf8convert(pin["name"]),
          id: pin["id"],
          image: pin["image"]));
    }

    return Memory(
        id: json["id"],
        pins: pins,
        aimId: json["aim_id"],
        userId: json["user_id"],
        name: utf8convert(json["name"]));
  }
}
