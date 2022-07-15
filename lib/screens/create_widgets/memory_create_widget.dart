import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/post_entities/memory_post.dart';
import 'package:dairy/providers/memories_provider.dart';

class MemoryCreateWidget extends StatefulWidget {
  final int aimId;
  final User user;
  const MemoryCreateWidget({Key? key, required this.aimId, required this.user})
      : super(key: key);

  @override
  State<MemoryCreateWidget> createState() => _MemoryCreateWidgetState();
}

class _MemoryCreateWidgetState extends State<MemoryCreateWidget> {
  TextEditingController nameController = TextEditingController();

  createMemory() async {
    context.read<MemoriesProvider>().create(MemoryPost(name: nameController.text), widget.user, widget.aimId);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создать воспоминание"),
      ),
      body: Center(
        child: Container(
          height: 500,
          width: 400,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      label: Text("Введите название для доски с воспоминаниями"))),
              ElevatedButton(onPressed: () => createMemory(), child: const Text("Готово"))
            ],
          ),
        ),
      ),
    );
  }
}
