import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/aim.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/post_repositories/task_post_repository.dart';
import 'package:dairy/providers/tasks_provider.dart';

class TaskCreateWidget extends StatefulWidget {
  final AuthorizedUser user;
  final Aim aim;
  const TaskCreateWidget({Key? key, required this.user, required this.aim})
      : super(key: key);

  @override
  State<TaskCreateWidget> createState() => _TaskCreateWidgetState();
}

class _TaskCreateWidgetState extends State<TaskCreateWidget> {
  TextEditingController nameController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  late TaskPostRepository taskPostRepository = TaskPostRepository();

  void selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  taskCreate() async {
    context.read<TasksProvider>().taskCreate(
        name: nameController.text,
        deadline: selectedDate,
        user: widget.user,
        aimId: widget.aim.id,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создайте новую задачу!"),
      ),
      body: Center(
        child: Container(
          height: 400,
          margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.2),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                controller: nameController,
                decoration:
                    const InputDecoration(hintText: "Введите название задачи"),
              ),
              ElevatedButton(
                  onPressed: selectDate,
                  child: const Text(
                      "Выберите дату до которой нужно выполнить задачу")),
              ElevatedButton(
                  onPressed: taskCreate, child: const Text("Добавить")),
            ],
          ),
        ),
      ),
    );
  }
}
