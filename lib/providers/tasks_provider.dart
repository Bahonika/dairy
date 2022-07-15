import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/task.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/get_repositories/task_repository.dart';
import 'package:dairy/entities/post_entities/task_post.dart';
import 'package:dairy/entities/post_repositories/task_post_repository.dart';
import 'package:dairy/providers/aims_provider.dart';

class TasksProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  TaskRepository taskRepository = TaskRepository();
  TaskPostRepository taskPostRepository = TaskPostRepository();

  changeStatus(Task task, String status, AuthorizedUser user, int aimId, BuildContext context) {
    TaskPost taskPost = TaskPost(
        name: task.name, deadline: task.deadline.toString(), status: status);
    taskPostRepository
        .update(taskPost, "${task.id}", user)
        .then((value) => getData(aimId, user, context));
  }

  taskCreate(
      {required String name,
      required DateTime deadline,
      required User user,
      required int aimId,
      required BuildContext context}) async {
    TaskPost taskPost =
        TaskPost(name: name, deadline: deadline.toString(), status: Task.todo);
    taskPostRepository
        .create(taskPost, user as AuthorizedUser,
            additionalEndpoint: "/$aimId/aim")
        .then((value) => Navigator.pop(context, true))
        .then((value) => getData(aimId, user, context));
  }

  void deleteTask(
      {required int taskId, required User user, required int aimId, required BuildContext context}) {
    taskPostRepository
        .delete(taskId.toString(), user as AuthorizedUser)
        .then((value) => getData(aimId, user, context));
  }

  void updateTask(
      {required TaskPost taskPost,
      required int taskId,
      required User user,
      required int aimId, required BuildContext context}) {
    taskPostRepository
        .update(taskPost, taskId.toString(), user as AuthorizedUser)
        .then((value) => getData(aimId, user, context));
  }

  Future<void> getData(int id, User user, BuildContext context) async {
    _tasks = await taskRepository.getAll(
        user: user as AuthorizedUser, additionalEndpoint: "/$id/aim");
    tasks.sort((a, b) => a.deadline.compareTo(b.deadline));
    context.read<AimsProvider>().getData(user);
    notifyListeners();
  }
}
