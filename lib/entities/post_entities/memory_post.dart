import 'package:dairy/entities/abstract/postable.dart';
import 'package:dairy/entities/get_enitites/pin.dart';


class MemoryPost implements Postable {
  final String name;


  MemoryPost({
    required this.name,
  });

  @override
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> pinsMaps = [];

    // for (Pin pin in pins){
    //   Map<String, dynamic> pinsMap = {
    //     "id": pin.id,
    //     "x" : pin.x,
    //     "y" : pin.y,
    //     "name" : pin.name,
    //     "image" : pin.image,
    //   };
    //   pinsMaps.add(pinsMap);
    // }


    var map = {
      "name": name,
      // "pins" : pinsMaps,
      // "id": id,
      // "user_id": userId,
      // "aim_id": aimId,
    };

    return map;
  }
}
