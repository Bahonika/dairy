import 'package:dairy/entities/abstract/post_update_repisitory.dart';
import 'package:dairy/entities/post_entities/post_post.dart';


class PostPostRepository extends PostUpdateRepository<PostPost>{

  @override
  late final String apiEndpoint = "api/post";

  @override
  PostPost fromJson(json) {
    throw UnimplementedError();
  }

  @override
  final String idAlias = "id";
}