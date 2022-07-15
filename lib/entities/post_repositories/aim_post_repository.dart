import 'package:dairy/entities/abstract/post_update_repisitory.dart';

import '../post_entities/aim_post.dart';

class AimPostRepository extends PostUpdateRepository<AimPost>{

  @override
  final String apiEndpoint = "/api/aim";

  @override
  AimPost fromJson(json) {
    throw UnimplementedError();
  }

  @override
  final String idAlias = "id";

}