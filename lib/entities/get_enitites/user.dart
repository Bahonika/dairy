import 'package:shared_preferences/shared_preferences.dart';
import 'package:dairy/utf_8_convert.dart';

class User {
  final String role;

  User({
    required this.role,
  });

  static const inspirer = "inspirer";
  static const dreamer = "dreamer";
  static const guest = "Гость";

  @override
  String toString() {
    return role;
  }

  bool isAuthorized() {
    return role != User.guest;
  }

  void save(SharedPreferences prefs) async {
    await prefs.setString('role', role);
  }

  void clear(SharedPreferences prefs) async {
    await prefs.remove('role');
  }
}

class GuestUser extends User {
  GuestUser() : super(role: User.guest);
}

class AuthorizedUser extends User {
  final String email;
  final String username;
  final String token;

  AuthorizedUser(
      {required String role,
      required this.email,
      required this.username,
      required this.token})
      : super(role: role);

  factory AuthorizedUser.fromJson(Map<String, dynamic> json) {
    return AuthorizedUser(
        role: utf8convert(json["user"]["role"]),
        email: utf8convert(json["user"]["email"]),
        username: utf8convert(json["user"]["username"]),
        token: utf8convert(json["token"]));
  }

  @override
  void clear(SharedPreferences prefs) async {
    super.clear(prefs);
    await prefs.remove('token');
    await prefs.remove('username');
    await prefs.remove('surname');
    await prefs.remove('email');
  }

  @override
  void save(SharedPreferences prefs) async {
    super.save(prefs);
    await prefs.setString('token', token);
    await prefs.setString('username', username);
    await prefs.setString('role', role);
    await prefs.setString('email', email);
  }
}

Future<User> restoreFromSharedPrefs(SharedPreferences prefs) async {
  var role = prefs.get('role') as String?;

  if (role == null || role == User.guest) {
    return GuestUser();
  }

  var token = prefs.get('token') as String?;
  var username = prefs.get('username') as String?;
  var email = prefs.get('email') as String?;

  return AuthorizedUser(
      role: role,
      email: email!,
      username: username!,
      token: token!);
}
