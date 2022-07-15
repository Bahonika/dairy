import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/post_entities/aim_post.dart';
import 'package:dairy/entities/post_repositories/aim_post_repository.dart';
import 'package:dairy/providers/aims_provider.dart';

import '../../entities/get_enitites/user.dart';

class AimCreateWidget extends StatefulWidget {
  final AuthorizedUser user;
  final String memoryName;
  const AimCreateWidget({Key? key, required this.user, this.memoryName = ""})
      : super(key: key);

  @override
  State<AimCreateWidget> createState() => _AimCreateWidgetState();
}

class _AimCreateWidgetState extends State<AimCreateWidget> {
  TextEditingController nameController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  AimPostRepository aimPostRepository = AimPostRepository();
  late AimPost aimPost;

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

  aimCreate() async {
    context
        .read<AimsProvider>()
        .aimCreate(nameController.text, selectedDate, widget.user)
        .then((value) => Navigator.pop(context, true));
  }

  @override
  void initState() {
    nameController.text = widget.memoryName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создайте новую цель!"),
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
                    const InputDecoration(hintText: "Введите название цели"),
              ),
              ElevatedButton(
                  onPressed: selectDate,
                  child: const Text(
                      "Выберите дату до которой нужно выполнить цель")),
              ElevatedButton(
                  onPressed: aimCreate, child: const Text("Добавить")),
            ],
          ),
        ),
      ),
    );
  }
}
