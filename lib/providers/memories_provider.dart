import 'package:flutter/material.dart';
import 'package:dairy/entities/get_enitites/memory.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/get_repositories/memory_repository.dart';
import 'package:dairy/entities/post_entities/memory_post.dart';
import 'package:dairy/entities/post_entities/pin_post.dart';
import 'package:dairy/entities/post_repositories/memory_post_repository.dart';
import 'package:dairy/entities/post_repositories/pin_post_repository.dart';

class MemoriesProvider with ChangeNotifier {
  List<Memory> _memories = <Memory>[];
  List<Memory> get memories => _memories;

  late Memory _memory;
  Memory get memory => _memory;

  MemoryRepository memoryRepository = MemoryRepository();
  MemoryPostRepository memoryPostRepository = MemoryPostRepository();

  deleteMemory(String id, User user) {
    memoryPostRepository
        .delete(id, user as AuthorizedUser)
        .then((value) => getData(user));
  }

  updateMemory(MemoryPost memoryPost, int dreamId, User user) {
    memoryPostRepository
        .update(memoryPost, dreamId.toString(), user as AuthorizedUser)
        .then((value) => getData(user));
  }

  create(MemoryPost memoryPost, User user, int aimId) {
    memoryPostRepository
        .create(memoryPost, user as AuthorizedUser, additionalEndpoint: "/$aimId/aim")
        .then((value) => getData(user));
  }

  PinPostRepository pinPostRepository = PinPostRepository();

  createPin(PinPost pinPost, User user, int memoryId) {
    pinPostRepository
        .create(pinPost, user as AuthorizedUser,
            additionalEndpoint: "/$memoryId/pin")
        .then((value) => getMemoryById(user, memoryId));
  }

  updatePin(PinPost pinPost, int memoryId, int pinId, User user) {
    pinPostRepository
        .update(pinPost, "$memoryId/pin/$pinId", user as AuthorizedUser)
        .then((value) => getMemoryById(user, memoryId));
  }

  deletePin(int memoryId, int pinId, User user) {
    pinPostRepository
        .delete("$memoryId/pin/$pinId", user as AuthorizedUser)
        .then((value) => getMemoryById(user, memoryId));
  }

  Future<void> getMemoryById(User user, int memoryId) async {
    _memory = await memoryRepository.getData(
        user: user as AuthorizedUser, additionalEndpoint: "/$memoryId");
    notifyListeners();
  }

  Future<void> getData(User user) async {
    _memories = await memoryRepository.getAll(user: user as AuthorizedUser);
    notifyListeners();
  }
}
