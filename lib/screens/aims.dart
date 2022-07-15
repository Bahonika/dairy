import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/aim.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/get_repositories/task_repository.dart';
import 'package:dairy/providers/aims_provider.dart';
import 'package:dairy/screens/create_widgets/aim_create_widget.dart';
import 'package:dairy/screens/create_widgets/memory_create_widget.dart';
import 'package:dairy/screens/tasks.dart';
import 'package:timelines/timelines.dart';

class Aims extends StatefulWidget {
  final User user;
  const Aims({Key? key, required this.user}) : super(key: key);

  @override
  State<Aims> createState() => _AimsState();
}

class _AimsState extends State<Aims> {
  TaskRepository taskRepository = TaskRepository();

  @override
  void initState() {
    context.read<AimsProvider>().getData(widget.user);
    super.initState();
  }

  void createAim() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AimCreateWidget(user: widget.user as AuthorizedUser)));
  }

  void deleteAim(String id) async {
    context.read<AimsProvider>().deleteAim(id, widget.user);
  }

  void toTasks(int index) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Tasks(
                user: widget.user,
                aim: context.watch<AimsProvider>().aims[index])));
  }

  DateTime now = DateTime.now();

  void toMemoryCreate(int aimId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MemoryCreateWidget(aimId: aimId, user: widget.user)));
  }

  @override
  Widget build(BuildContext context) {
    List<Aim> aims = context.watch<AimsProvider>().aims;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Цели"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: FixedTimeline.tileBuilder(
          builder: TimelineTileBuilder.connected(
              contentsAlign: ContentsAlign.alternating,
              oppositeContentsBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DateFormat.yMMMMd('ru_RU')
                          .format(aims[index].deadline)
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
              contentsBuilder: (context, index) {
                return InkWell(
                  onTap: () => toTasks(index),
                  child: Row(
                    mainAxisAlignment: (index.isOdd)
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (index.isOdd)
                        IconButton(
                            onPressed: () {
                              deleteAim(aims[index].id.toString());
                            },
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.red,
                            )),
                      if (index.isOdd)
                        IconButton(
                            onPressed: () {
                              toMemoryCreate(aims[index].id);
                            },
                            icon: const Icon(
                              Icons.today,
                              color: Colors.red,
                            )),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 8),
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(aims[index].name),
                      ),
                      if (index.isEven)
                        IconButton(
                            onPressed: () {
                              toMemoryCreate(aims[index].id);
                            },
                            icon: const Icon(
                              Icons.today,
                              color: Colors.red,
                            )),
                      if (index.isEven)
                        IconButton(
                            onPressed: () =>
                                deleteAim(aims[index].id.toString()),
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.red,
                            ))
                    ],
                  ),
                );
              },
              itemCount: aims.length,
              indicatorBuilder: (context, index) {
                if (aims[index].isDone) {
                  return const DotIndicator(color: Colors.green);
                } else {
                  if (aims[index].deadline.isBefore(now)) {
                    return const OutlinedDotIndicator(color: Colors.red);
                  } else {
                    return const OutlinedDotIndicator(color: Colors.yellow);
                  }
                }
              },
              connectorBuilder: (context, index, _) {
                if (aims[index].isDone) {
                  return const SolidLineConnector(color: Colors.green);
                } else {
                  if (aims[index].deadline.isBefore(now)) {
                    return const DashedLineConnector(color: Colors.red);
                  } else {
                    return const DashedLineConnector(color: Colors.yellow);
                  }
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Создать цель"),
        onPressed: createAim,
        icon: const Icon(Icons.add),
      ),
    );
  }
}
