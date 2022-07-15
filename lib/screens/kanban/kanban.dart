import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/post_repositories/task_post_repository.dart';
import 'package:dairy/providers/tasks_provider.dart';
import 'package:dairy/screens/kanban/bar_target.dart';
import 'package:dairy/screens/kanban/task_widget.dart';

import '../../entities/get_enitites/aim.dart';
import '../../entities/get_enitites/task.dart';

class Kanban extends StatefulWidget {
  final Aim aim;
  final AuthorizedUser user;
  final List<Task> tasks;
  const Kanban(
      {Key? key, required this.aim, required this.user, required this.tasks})
      : super(key: key);

  @override
  KanbanState createState() => KanbanState();
}

class KanbanState extends State<Kanban> {
  TaskPostRepository taskPostRepository = TaskPostRepository();
  var dragging = false;

  Map<String, List<Task>> sortedTasks = <String, List<Task>>{
    Task.todo: <Task>[],
    Task.inProgress: <Task>[],
    Task.done: <Task>[]
  };

  void taskSorting(List<Task> tasks) {
    Map<String, List<Task>> tempSortedTasks = <String, List<Task>>{
      Task.todo: <Task>[],
      Task.inProgress: <Task>[],
      Task.done: <Task>[]
    };
    for (int i = 0; i < tasks.length; i++) {
      tempSortedTasks[tasks[i].status]?.add(tasks[i]);
    }
    sortedTasks = tempSortedTasks;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    taskSorting(context.watch<TasksProvider>().tasks);
      return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            children: sortedTasks.keys
                .map((name) => DragTarget<List<dynamic>>(
                      onWillAccept: (data) => true,

                      /// Actually moving tasks happens here. The payload of a task is a List<String> which contains
                      /// the task's contents and its category
                      onAccept: (data) {
                        context.read<TasksProvider>().changeStatus(
                            data[0], name, widget.user, widget.aim.id, context);
                      },
                      builder: (context, candidateData, rejectedData) =>
                          Container(
                        decoration: const BoxDecoration(
                            border:
                                Border(right: BorderSide(color: Colors.white))),

                        /// A board's width is at least 200 logical pixels
                        /// or 1/number of boards of the entire screen width
                        width: max(
                            MediaQuery.of(context).size.width /
                                sortedTasks.keys.length,
                            200),
                        child: ListView(
                          children: <Widget>[
                            ListTile(
                                title: Text(
                              name,
                              style: const TextStyle(color: Colors.white),
                            )),
                            const Divider(
                              color: Colors.white,
                            ),
                            ...sortedTasks[name]!.map(
                              /// The callbacks are used to determine if the Delete Bar should be shown
                              (t) => TaskWidget(
                                tasks: [t, name],
                                dragStartedCallback: () {
                                  setState(() {
                                    dragging = true;
                                  });
                                },
                                dragEndCallback: (details) =>
                                    setState(() => dragging = false),
                                width: max(
                                    (MediaQuery.of(context).size.width /
                                            sortedTasks.keys.length) +
                                        20,
                                    220),
                                aim: widget.aim,
                                user: widget.user,
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
          if (dragging)
            BarTarget<List<Task>>(
              width: max(MediaQuery.of(context).size.width,
                  sortedTasks.keys.length * 200.0),
              height: 64,
              color: Colors.red,
              child: const Icon(Icons.delete),
              onAccept: (data) {
                context.read<TasksProvider>().deleteTask(
                    taskId: data[0].id,
                    user: widget.user,
                    aimId: widget.aim.id,
                    context: context
                );
                // context.read<AimsProvider>().getData(widget.user);
              },
            ),
        ],
      ),
    ));
  }
}
