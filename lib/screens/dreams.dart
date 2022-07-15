import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/dream.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/post_repositories/dream_post_repository.dart';
import 'package:dairy/providers/dreams_provider.dart';
import 'package:dairy/screens/create_widgets/aim_create_widget.dart';

import '../entities/get_repositories/dream_repository.dart';
import '../entities/post_entities/dream_post.dart';

class Dreams extends StatefulWidget {
  final AuthorizedUser user;

  const Dreams({Key? key, required this.user}) : super(key: key);

  @override
  State<Dreams> createState() => _DreamsState();
}

class _DreamsState extends State<Dreams> {
  TextEditingController addTextController = TextEditingController();
  TextEditingController updateTextController = TextEditingController();

  List<Dream> dreams = <Dream>[];

  addDialog() {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: addTextController,
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: const InputDecoration(
                  hintText: "Например: купить ноутбук",
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary),
                  child: const Text("Отмена"),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<DreamsProvider>().create(
                          DreamPost(name: addTextController.text), widget.user);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary),
                    child: const Text("Добавить")),
              ],
            )
          ],
        ),
      ),
    );
  }

  updateDialog(int index) {
    updateTextController.text = dreams[index].name;
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: updateTextController,
                cursorColor: Theme.of(context).colorScheme.secondary,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary),
                  child: const Text("Отмена"),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<DreamsProvider>().updateDream(
                          DreamPost(name: updateTextController.text),
                          dreams[index].id,
                          widget.user);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary),
                    child: const Text("Изменить")),
              ],
            )
          ],
        ),
      ),
    );
  }

  void createAim(String memoryName) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AimCreateWidget(
                  user: widget.user,
                  memoryName: memoryName,
                )));
  }

  @override
  void initState() {
    context.read<DreamsProvider>().getData(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dreams = context.watch<DreamsProvider>().dreams;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Мечты"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text("Мечта №${index + 1}"),
                    subtitle: Text(dreams[index].name),
                    trailing: SizedBox(
                      width: kIsWeb
                          ? 120
                          : Platform.isIOS || Platform.isAndroid
                              ? 100
                              : 200,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                createAim(dreams[index].name);
                              },
                              icon: const Icon(
                                Icons.read_more_outlined,
                                color: Colors.green,
                              )),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => updateDialog(index));
                              },
                              icon: const Icon(
                                Icons.border_color_outlined,
                                color: Colors.black,
                              )),
                          IconButton(
                              onPressed: () {
                                context.read<DreamsProvider>().deleteDream(
                                    dreams[index].id.toString(), widget.user);
                              },
                              icon: const Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: dreams.length,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: "Добавить новую мечту",
        label: const Text("Создать мечту"),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return addDialog();
              });
        },
      ),
    );
  }
}
