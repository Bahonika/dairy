import 'package:flutter/material.dart';
import 'package:dairy/entities/get_enitites/theme.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/get_repositories/theme_repository.dart';

class ThemeProvider with ChangeNotifier {
  List<ThemeEntity> _themes = [];
  List<ThemeEntity> get themes => _themes;

  ThemeRepository themeRepository = ThemeRepository();


  getData(User user) async {
    _themes = await themeRepository.getAll(user: user as AuthorizedUser);
    notifyListeners();
  }


}
