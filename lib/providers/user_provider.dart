import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dairy/entities/get_enitites/self_info.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/get_repositories/auth_user.dart';
import 'package:dairy/entities/get_repositories/self_info_repository.dart';

class UserProvider with ChangeNotifier {
  late AuthorizedUser _user;
  AuthorizedUser get user => _user;

  List<UserInfo> _inspirers = [];
  SelfInfoRepository selfInfoRepository = SelfInfoRepository();
  List<UserInfo> get inspirers => _inspirers;

  getInsiprers(User user) async {
    _inspirers = await selfInfoRepository.getAll(
        user: user as AuthorizedUser, additionalEndpoint: "/inspirer");
    notifyListeners();
  }

  bool _isAuthFailed = false;
  bool get isAuthFailed => _isAuthFailed;

  AuthUser authUser = AuthUser();

  // pushToHomePage(BuildContext context) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               WillPopScope(onWillPop: () async => false, child: const HomePage(user: _user!,))));
  // }

  void login(
      {required String login,
      required String password,
      required BuildContext context}) async {
    try {
      _user = await authUser.auth(login, password);
      var prefs = await SharedPreferences.getInstance();
      _user.save(prefs);
      _isAuthFailed = false;
    } on AuthorizationException {
      _isAuthFailed = true;
    }
  }
}
