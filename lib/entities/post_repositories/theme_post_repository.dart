import 'package:dairy/entities/abstract/post_update_repisitory.dart';
import 'package:dairy/entities/post_entities/theme_post.dart';

class ThemePostRepository extends PostUpdateRepository<ThemePost> {
  @override
  late final String apiEndpoint = "api/theme";

  @override
  ThemePost fromJson(json) {
    throw UnimplementedError();
  }

  @override
  final String idAlias = "id";
}
