import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dairy/entities/get_enitites/idea.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/post_repositories/idea_post_repository.dart';

import '../entities/get_repositories/idea_repository.dart';
import '../entities/post_entities/idea_post.dart';

class Ideas extends StatefulWidget {
  final AuthorizedUser user;

  const Ideas({Key? key, required this.user}) : super(key: key);

  @override
  State<Ideas> createState() => _IdeasState();
}

class _IdeasState extends State<Ideas> {
  TextEditingController addTextController = TextEditingController();
  TextEditingController updateTextController = TextEditingController();

  List<Idea> ideas = <Idea>[];

  IdeaRepository ideaRepository = IdeaRepository();
  IdeaPostRepository ideaPostRepository = IdeaPostRepository();

  createIdea() {
    if (addTextController.text != "") {
      IdeaPost ideaPost = IdeaPost(name: addTextController.text);
      ideaPostRepository
          .create(ideaPost, widget.user)
          .then((value) => Navigator.pop(context))
          .then((value) => getData());
    }
    addTextController.clear();
  }

  deleteIdea(String id) {
    ideaPostRepository.delete(id, widget.user).then((value) => getData());
  }

  updateIdea(String id) {
    IdeaPost ideaPost = IdeaPost(name: updateTextController.text);
    ideaPostRepository
        .update(ideaPost, id, widget.user)
        .then((value) => getData())
        .then((value) => Navigator.pop(context));
  }

  Future<void> getData() async {
    ideas = await ideaRepository.getAll(user: widget.user);
    setState(() {});
  }

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
                  hintText: "Например: завести личный дневник",
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
                    onPressed: createIdea,
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
    updateTextController.text = ideas[index].name;
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
                    onPressed: () => updateIdea(ideas[index].id.toString()),
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

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Идеи"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color.fromRGBO(251, 149, 159, 1),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text("Идея №${index + 1}",
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        )),
                  ),
                  Align(
                    alignment: const Alignment(0, 0),
                    child: Text(
                      ideas[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        // Not so good, but ok to set it const value
                        //need some calc value
                        height: 50,
                        width: 80,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          updateDialog(index));
                                },
                                icon:  Icon(
                                  Icons.border_color_outlined,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                )),
                            IconButton(
                                onPressed: () {
                                  deleteIdea(ideas[index].id.toString());
                                },
                                icon: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      )),
                ],
              ));
        },
        itemCount: ideas.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (MediaQuery.of(context).size.width / 250).round()),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Добавить новую мечту",
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return addDialog();
              });
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
