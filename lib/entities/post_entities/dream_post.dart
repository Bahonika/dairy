import '../abstract/postable.dart';

class DreamPost implements Postable {
  final String name;

  DreamPost({required this.name});

  @override
  Map<String, dynamic> toJson() {
    var map = {
      'name': name,
    };

    return map;
  }
}
