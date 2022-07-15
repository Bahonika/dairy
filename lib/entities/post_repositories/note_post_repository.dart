import 'package:dairy/entities/abstract/post_update_repisitory.dart';
import 'package:dairy/entities/post_entities/note_post.dart';

class NotePostRepository extends PostUpdateRepository<NotePost>{

  @override
  late final String apiEndpoint = "api/note";

  @override
  NotePost fromJson(json) {
    throw UnimplementedError();
  }

  @override
  final String idAlias = "id";
}