import '../abstract/postable.dart';

class PostPost implements Postable {
  final String name;
  final String body;
  final List<int> themes;

  PostPost({required this.body, required this.themes, required this.name});

  @override
  Map<String, dynamic> toJson() {
    var map = {'name': name, "body": body, 'themes': themes};

    return map;
  }
}
