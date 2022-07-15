import 'package:dairy/entities/abstract/post_update_repisitory.dart';

import '../post_entities/task_post.dart';

class TaskPostRepository extends PostUpdateRepository<TaskPost>{

  @override
  late final String apiEndpoint = "api/task";

  @override
  TaskPost fromJson(json) {
    throw UnimplementedError();
  }

  @override
  final String idAlias = "id";
}