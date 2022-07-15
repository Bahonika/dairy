import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/aim.dart';
import 'package:dairy/entities/get_repositories/task_repository.dart';
import 'package:dairy/providers/tasks_provider.dart';
import 'package:dairy/screens/kanban/kanban.dart';
import 'package:dairy/screens/create_widgets/task_create_widget.dart';
import 'package:dairy/screens/widgets/task_timeline.dart';

import '../entities/get_enitites/user.dart';

class Tasks extends StatefulWidget {
  final User user;
  final Aim aim;

  const Tasks({Key? key, required this.user, required this.aim})
      : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> with SingleTickerProviderStateMixin {
  late TaskRepository taskRepository = TaskRepository();

  // Navigate to create screen with task create widget
  void toCreateWidget() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TaskCreateWidget(
                  user: widget.user as AuthorizedUser,
                  aim: widget.aim,
                )));
  }

  DateTime now = DateTime.now();
  late TabController tabController;

  @override
  void initState() {
    context.read<TasksProvider>().getData(widget.aim.id, widget.user, context);
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Задачи к цели \"${widget.aim.name}\""),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Icon(Icons.view_timeline_outlined),
            Icon(Icons.view_kanban_outlined)
          ],
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        TasksTimeline(tasks: context.watch<TasksProvider>().tasks),
        Kanban(
          tasks: context.watch<TasksProvider>().tasks,
          aim: widget.aim,
          user: widget.user as AuthorizedUser,
        )
      ]),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Создать задачу"),
        onPressed: toCreateWidget,
        icon: const Icon(Icons.add),
      ),
    );
  }
}
