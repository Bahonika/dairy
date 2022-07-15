import 'package:dairy/entities/abstract/post_update_repisitory.dart';
import 'package:dairy/entities/post_entities/pin_post.dart';

class PinPostRepository extends PostUpdateRepository<PinPost>{

  @override
  late final String apiEndpoint = "api/memory";

  @override
  PinPost fromJson(json) {
    throw UnimplementedError();
  }

  @override
  final String idAlias = "id";
}