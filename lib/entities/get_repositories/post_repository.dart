import 'package:dairy/entities/get_enitites/post.dart';

import '../abstract/basic.dart';

class PostRepository extends BasicRepository<Post>{

  @override
  final String apiEndpoint = "api/post";

  @override
  Post fromJson(json) {
    return Post.fromJson(json);
  }
}