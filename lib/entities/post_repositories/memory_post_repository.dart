import 'package:dairy/entities/abstract/post_update_repisitory.dart';
import 'package:dairy/entities/post_entities/memory_post.dart';

class MemoryPostRepository extends PostUpdateRepository<MemoryPost>{
  @override
  final String apiEndpoint = "/api/memory";

  @override
  fromJson(json) {
    throw UnimplementedError();
  }

  @override
  final String idAlias = "id";

}