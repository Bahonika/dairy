import '../abstract/postable.dart';

class IdeaPost implements Postable {
  final String name;

  IdeaPost({required this.name});

  @override
  Map<String, dynamic> toJson() {
    var map = {
      'name': name,
    };

    return map;
  }
}
