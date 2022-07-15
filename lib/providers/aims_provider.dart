import 'package:flutter/material.dart';
import 'package:dairy/entities/get_enitites/aim.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/get_repositories/aim_repository.dart';
import 'package:dairy/entities/post_entities/aim_post.dart';
import 'package:dairy/entities/post_repositories/aim_post_repository.dart';

class AimsProvider with ChangeNotifier {
  List<Aim> _aims = [];
  List<Aim> get aims => _aims;

  AimPostRepository aimPostRepository = AimPostRepository();
  AimRepository aimRepository = AimRepository();

  getData(User user) async {
    _aims = await aimRepository.getAll(user: user as AuthorizedUser);
    _aims.sort((a, b) => a.deadline.compareTo(b.deadline));
    notifyListeners();
  }

  aimCreate(String name, DateTime deadline, User user) async {
    AimPost aimPost = AimPost(name: name, deadline: deadline.toString());
    aimPostRepository
        .create(aimPost, user as AuthorizedUser)
        .then((value) => getData(user));
  }

  void deleteAim(String id, User user) async {
    aimPostRepository
        .delete(id, user as AuthorizedUser)
        .then((value) => getData(user));
  }
}
