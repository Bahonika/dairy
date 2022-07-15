import 'package:flutter/material.dart';
import 'package:dairy/entities/get_enitites/self_info.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/get_repositories/self_info_repository.dart';
import 'package:dairy/entities/post_entities/theme_post.dart';
import 'package:dairy/entities/post_repositories/theme_post_repository.dart';

class SelfInfoProvider with ChangeNotifier {
  late UserInfo _selfInfo;

  UserInfo get selfInfo => _selfInfo;

  SelfInfoRepository selfInfoRepository = SelfInfoRepository();

  getData(User user) async {
    _selfInfo =
        (await selfInfoRepository.getData(user: user as AuthorizedUser));
    notifyListeners();
  }

  ThemePostRepository themePostRepository = ThemePostRepository();
  setFavorite(User user, int themeId) {
    themePostRepository
        .create(ThemePost(name: "hey"), user as AuthorizedUser,
            additionalEndpoint: "/$themeId/favorite")
        .then((value) => getData(user));
  }

  deleteFavorite(User user, int themeId){
    themePostRepository.delete("$themeId/favorite", user as AuthorizedUser).then((value) => getData(user));
  }
}
