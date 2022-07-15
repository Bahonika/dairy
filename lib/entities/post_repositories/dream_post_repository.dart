import 'package:dairy/entities/abstract/post_update_repisitory.dart';

import '../post_entities/dream_post.dart';

class DreamPostRepository extends PostUpdateRepository<DreamPost>{

  @override
  final String apiEndpoint = "/api/dream";

  @override
  DreamPost fromJson(json) {
    throw UnimplementedError();
  }

  @override
  final String idAlias = "id";
}