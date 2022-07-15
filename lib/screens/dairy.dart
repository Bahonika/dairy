import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/post_entities/note_post.dart';
import 'package:dairy/providers/note_provider.dart';

import '../entities/get_enitites/user.dart';
import '../entities/get_repositories/note_repository.dart';
import '../entities/get_enitites/note.dart';

class Dairy extends StatefulWidget {
  final User user;

  const Dairy({Key? key, required this.user}) : super(key: key);

  @override
  State<Dairy> createState() => _DairyState();
}

class _DairyState extends State<Dairy> {
  List<Note> notes = <Note>[];
  NoteRepository noteRepository = NoteRepository();

  TextEditingController addTextController = TextEditingController();
  TextEditingController updateTextController = TextEditingController();

  // dialog of create a new note
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
                  hintText:
                      "Например: сегодня неплохое настроение, потому что...",
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
                      context.read<NoteProvider>().create(
                          NotePost(name: addTextController.text), widget.user);
                      addTextController.text = "";
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

  // dialog of update an existing note
  updateDialog(int index) {
    updateTextController.text = notes[index].name;
    print(index);
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
                      context.read<NoteProvider>().updateNote(
                          NotePost(name: updateTextController.text),
                          notes[index].id,
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

  // read and get from provider
  Future<void> getData() async {
    context.read<NoteProvider>().getData(widget.user);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // cut to two lists to beautiful ui
    notes = context.watch<NoteProvider>().notes;
    List<Note> oddList = [];
    List<Note> evenList = [];

    for (int i = 0; i < context.watch<NoteProvider>().notes.length; i++) {
      if (i.isOdd) {
        oddList.add(context.watch<NoteProvider>().notes[i]);
      } else {
        evenList.add(context.watch<NoteProvider>().notes[i]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Дневник"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: evenList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.all(4),
                    color: Theme.of(context).colorScheme.secondary,
                    height: 100,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text("Запись №${(index * 2) + 1}"),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(evenList[index].name),
                        ),
                        Align(
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) =>
                                          updateDialog(index * 2)),
                                  icon:
                                      const Icon(Icons.border_color_outlined)),
                              IconButton(
                                  onPressed: () => context
                                      .read<NoteProvider>()
                                      .deleteNote(
                                          notes[index * 2].id.toString(),
                                          widget.user),
                                  icon: const Icon(
                                      Icons.delete_forever_outlined)),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: oddList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.all(4),
                    color: Theme.of(context).colorScheme.secondary,
                    height: 100,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text("Запись №${(index + 1) * 2}"),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(oddList[index].name),
                        ),
                        Align(
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) =>
                                          updateDialog((index * 2) + 1)),
                                  icon:
                                      const Icon(Icons.border_color_outlined)),
                              IconButton(
                                  onPressed: () => context
                                      .read<NoteProvider>()
                                      .deleteNote(
                                          notes[(index * 2) + 1].id.toString(),
                                          widget.user),
                                  icon: const Icon(
                                      Icons.delete_forever_outlined)),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Записать идею"),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return addDialog();
              });
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
