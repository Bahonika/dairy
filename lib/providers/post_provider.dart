import 'package:flutter/material.dart';
import 'package:dairy/entities/get_enitites/post.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/get_repositories/post_repository.dart';
import 'package:dairy/entities/post_entities/post_post.dart';
import 'package:dairy/entities/post_repositories/post_post_repository.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  List<Post> get posts => _posts;

  PostRepository postRepository = PostRepository();
  PostPostRepository postPostRepository = PostPostRepository();

  getData(User user) async {
    _posts = await postRepository.getAll(
        user: user as AuthorizedUser, additionalEndpoint: "/0/user");
    notifyListeners();
  }

  createPost(PostPost postPost, User user) {
    postPostRepository
        .create(postPost, user as AuthorizedUser)
        .then((value) => getData(user));
  }
}
