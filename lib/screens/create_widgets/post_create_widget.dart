import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/theme.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/post_entities/post_post.dart';
import 'package:dairy/providers/post_provider.dart';

class PostCreateWidget extends StatefulWidget {
  final AuthorizedUser user;

  const PostCreateWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<PostCreateWidget> createState() => _PostCreateWidgetState();
}

class _PostCreateWidgetState extends State<PostCreateWidget> {

  TextEditingController nameController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  List<int> themesIds = [];
  List<ThemeEntity> themes = [];

  postCreate(){
    PostPost postPost = PostPost(body: bodyController.text, themes: themesIds, name: nameController.text);
    context.read<PostProvider>().createPost(postPost, widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создайте новую запись!"),
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
                const InputDecoration(hintText: "Введите название записи"),
              ),
              TextFormField(
                controller: bodyController,
                decoration:
                const InputDecoration(hintText: "Введите содержание записи"),
              ),
              ElevatedButton(
                  onPressed: postCreate, child: const Text("Добавить")),
            ],
          ),
        ),
      ),
    );;
  }
}
