import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/aim.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/post_entities/task_post.dart';
import 'package:dairy/providers/tasks_provider.dart';

typedef DragEndCallback = void Function(DraggableDetails details);

class TaskWidget extends StatefulWidget {
  final List<dynamic> tasks;
  final VoidCallback dragStartedCallback;
  final DragEndCallback dragEndCallback;
  final double width;
  final Aim aim;
  final User user;

  const TaskWidget(
      {Key? key,
      required this.tasks,
      required this.dragStartedCallback,
      required this.dragEndCallback,
      required this.width,
      required this.aim,
      required this.user})
      : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isNowChange = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text = widget.tasks[0].name;
    super.initState();
  }

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Draggable<List<dynamic>>(
      data: widget.tasks,
      onDragStarted: widget.dragStartedCallback,
      onDragEnd: widget.dragEndCallback,
      feedback: SizedBox(
        width: widget.width + 20,
        height: 64,
        child: Card(
          elevation: 4,
          child: ListTile(
            title: Text(widget.tasks[0].name),
          ),
        ),
      ),
      child: InkWell(
        onTap: () => null,
        onHover: (value) {
          setState(() {
            isHover = value;
          });
        },
        child: SizedBox(
          width: widget.width,
          height: 64,
          child: Card(
            child: ListTile(
              title: isNowChange
                  ? TextFormField(
                      controller: textEditingController,
                    )
                  : Text(widget.tasks[0].name),
              trailing: isHover
                  ? SizedBox(
                      width: isNowChange ? 80 : 40,
                      child: Row(
                        children: [
                          if (isNowChange)
                            IconButton(
                              onPressed: () {
                                context.read<TasksProvider>().updateTask(context: context,
                                    taskPost: TaskPost(
                                        deadline:
                                            widget.tasks[0].deadline.toString(),
                                        name: textEditingController.text,
                                        status: widget.tasks[0].status),
                                    taskId: widget.tasks[0].id,
                                    user: widget.user,
                                    aimId: widget.aim.id);
                                isNowChange = !isNowChange;
                              },
                              icon: const Icon(Icons.done, color: Colors.green),
                            ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isNowChange = !isNowChange;
                              });
                            },
                            icon: isNowChange
                                ? const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.border_color_outlined),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}
