import 'package:flutter/material.dart';
import 'package:dairy/entities/get_enitites/dream.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/get_repositories/dream_repository.dart';
import 'package:dairy/entities/post_entities/dream_post.dart';
import 'package:dairy/entities/post_repositories/dream_post_repository.dart';

class DreamsProvider with ChangeNotifier {
  List<Dream> _dreams = <Dream>[];
  List<Dream> get dreams => _dreams;

  DreamRepository ideaRepository = DreamRepository();
  DreamPostRepository ideaPostRepository = DreamPostRepository();

  deleteIdea(String id, User user) {
    ideaPostRepository
        .delete(id, user as AuthorizedUser)
        .then((value) => getData(user));
  }

  updateIdea(DreamPost dreamPost, int dreamId, User user) {
    ideaPostRepository
        .update(dreamPost, dreamId.toString(), user as AuthorizedUser)
        .then((value) => getData(user));
  }

  create(DreamPost dreamPost, User user) {
    ideaPostRepository
        .create(dreamPost, user as AuthorizedUser)
        .then((value) => getData(user));
  }

  Future<void> getData(User user) async {
    _dreams = await ideaRepository.getAll(user: user as AuthorizedUser);
    notifyListeners();
  }
}
