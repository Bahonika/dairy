import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dairy/entities/get_enitites/task.dart';
import 'package:timelines/timelines.dart';

class TasksTimeline extends StatefulWidget {
  final List<Task> tasks;
  const TasksTimeline({Key? key, required this.tasks}) : super(key: key);

  @override
  State<TasksTimeline> createState() => _TasksTimelineState();
}

class _TasksTimelineState extends State<TasksTimeline> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {

    return Timeline.tileBuilder(
      builder: TimelineTileBuilder.connected(
          contentsAlign: ContentsAlign.alternating,
          oppositeContentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat.yMMMMd('ru_RU')
                      .format(widget.tasks[index].deadline)
                      .toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
          itemCount: widget.tasks.length,
          contentsBuilder: (context, index) => Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(widget.tasks[index].name),
              ),
          connectorBuilder: (context, index, __) {
            if (widget.tasks[index].status == Task.todo ||
                widget.tasks[index].status == Task.inProgress) {
              if (widget.tasks[index].deadline.isBefore(now)){
                return const DashedLineConnector(
                  color: Colors.red,
                );
              }
              return const DashedLineConnector(
                color: Colors.yellow,
              );
            } else {
              return const SolidLineConnector(
                color: Colors.green,
              );
            }
          },
          indicatorBuilder: (context, index) {
            switch (widget.tasks[index].status) {
              case Task.done:
                return const DotIndicator(
                  color: Color(0xff6ad192),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 15.0,
                  ),
                );
              case Task.inProgress:
                if (widget.tasks[index].deadline.isBefore(now)){
                  return const OutlinedDotIndicator(
                    color: Colors.red,
                  );
                }
                return const DotIndicator(
                  color: Colors.yellow,
                );
              case Task.todo:
                if (widget.tasks[index].deadline.isBefore(now)){
                  return const OutlinedDotIndicator(
                    color: Colors.red,
                  );
                }
                return const OutlinedDotIndicator(
                  color: Colors.yellow,
                );
              default:
                return const OutlinedDotIndicator(
                  color: Colors.yellow,
                );
            }
          }
          ),
    );
  }
}
