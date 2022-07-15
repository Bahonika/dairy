import 'package:dairy/entities/get_enitites/theme.dart';
import 'package:dairy/utf_8_convert.dart';

class UserInfo {
  final int id;
  final String email;
  final String username;
  final String role;
  final List<ThemeEntity> themes;
  final List<ExtendedUser> inspirers;

  UserInfo({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
    required this.themes,
    required this.inspirers,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    List<ThemeEntity> themes = [];
    List<ExtendedUser> users = [];
    for (Map<String, dynamic> theme in json["user_themes"]) {
      themes
          .add(ThemeEntity(id: theme["id"], name: utf8convert(theme["name"])));
    }
    for (Map<String, dynamic> user in json["user_inspirer"]) {
      users.add(ExtendedUser(
          username: utf8convert(user["username"]),
          id: user["id"],
          email: utf8convert(user["email"]),
          role: utf8convert(user["role"])));
    }
    return UserInfo(
        email: utf8convert(json['email']),
        id: json["id"],
        themes: themes,
        inspirers: users,
        role: utf8convert(json['role']),
        username: utf8convert(json['username']));
  }
}

class ExtendedUser {
  final int id;
  final String email;
  final String username;
  final String role;

  ExtendedUser({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
  });

  factory ExtendedUser.fromJson(Map<String, dynamic> json) {
    return ExtendedUser(
        email: utf8convert(json['email']),
        id: json["id"],
        role: utf8convert(json['role']),
        username: utf8convert(json['username']));
  }
}
