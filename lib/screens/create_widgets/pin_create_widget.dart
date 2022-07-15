import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/post_entities/pin_post.dart';
import 'package:dairy/providers/memories_provider.dart';

class PinCreateWidget extends StatefulWidget {
  final int memoryId;
  final User user;
  const PinCreateWidget({Key? key, required this.memoryId, required this.user})
      : super(key: key);

  @override
  State<PinCreateWidget> createState() => _PinCreateWidgetState();
}

class _PinCreateWidgetState extends State<PinCreateWidget> {
  ImagePicker imagePicker = ImagePicker();
  XFile? image;
  String base64Image = "";

  TextEditingController nameController = TextEditingController();

  pickImage() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  createPin() async {
    if (image != null) {
      base64Image = base64Encode(await image!.readAsBytes());
    }
    context.read<MemoriesProvider>().createPin(
          PinPost(image: base64Image, name: nameController.text, x: 1, y: 1),
          widget.user,
          widget.memoryId,
        );
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
                      label: Text("Введите название воспоминания"))),
              ElevatedButton(
                  onPressed: () => pickImage(),
                  child: const Text("Выбрать картинку")),
              ElevatedButton(onPressed: () => createPin(), child: const Text("Готово")),
            ],
          ),
        ),
      ),
    );
  }
}
