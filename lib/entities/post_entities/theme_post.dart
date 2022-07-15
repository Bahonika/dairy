import 'package:dairy/entities/abstract/postable.dart';

class ThemePost implements Postable {
  final String name;
  ThemePost({required this.name});

  @override
  Map<String, dynamic> toJson() {
    var map = {"name": name};
    return map;
  }
}
