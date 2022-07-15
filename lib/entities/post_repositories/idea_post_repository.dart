import 'package:dairy/entities/abstract/post_update_repisitory.dart';
import 'package:dairy/entities/post_entities/idea_post.dart';

class IdeaPostRepository extends PostUpdateRepository<IdeaPost>{

  @override
  final String apiEndpoint = "/api/idea";

  @override
  IdeaPost fromJson(json) {
    throw UnimplementedError();
  }

  @override
  final String idAlias = "id";

}