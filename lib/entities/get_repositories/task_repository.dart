import '../abstract/basic.dart';
import '../get_enitites/task.dart';

class TaskRepository extends BasicRepository<Task> {
  // final int aimId;
  //
  // TaskRepository({required this.aimId});

  @override
  late final String apiEndpoint = "api/task";
  late String additionalEndpoit;

  @override
  Task fromJson(json) {
    return Task.fromJson(json);
  }
}
