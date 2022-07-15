import '../abstract/postable.dart';

class NotePost implements Postable {
  final String name;

  NotePost({required this.name});

  @override
  Map<String, dynamic> toJson() {
    var map = {
      'name': name,
    };

    return map;
  }
}
