import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/memory.dart';
import 'package:dairy/entities/get_enitites/pin.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/post_entities/pin_post.dart';
import 'package:dairy/providers/memories_provider.dart';
import 'package:dairy/screens/create_widgets/pin_create_widget.dart';

class Memories extends StatefulWidget {
  final User user;

  const Memories({Key? key, required this.user}) : super(key: key);

  @override
  State<Memories> createState() => _MemoriesState();
}

class _MemoriesState extends State<Memories> {
  @override
  void initState() {
    context.read<MemoriesProvider>().getData(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Воспоминания"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => MemoryButtonWidget(
          memory: context.watch<MemoriesProvider>().memories[index],
          user: widget.user,
        ),
        itemCount: context.watch<MemoriesProvider>().memories.length,
      ),
    );
  }
}

class MemoryButtonWidget extends StatefulWidget {
  final Memory memory;
  final User user;
  const MemoryButtonWidget({Key? key, required this.memory, required this.user})
      : super(key: key);

  @override
  State<MemoryButtonWidget> createState() => _MemoryButtonWidgetState();
}

class _MemoryButtonWidgetState extends State<MemoryButtonWidget> {
  @override
  void initState() {
    context
        .read<MemoriesProvider>()
        .getMemoryById(widget.user, widget.memory.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 500,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.secondary),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MemoryWidget(
                      memoryId: widget.memory.id,
                      user: widget.user,
                    ))),
        child: Text(widget.memory.name),
      ),
    );
  }
}

class MemoryWidget extends StatefulWidget {
  final User user;
  final int memoryId;
  const MemoryWidget({Key? key, required this.memoryId, required this.user})
      : super(key: key);

  @override
  State<MemoryWidget> createState() => _MemoryWidgetState();
}

class _MemoryWidgetState extends State<MemoryWidget> {
  TransformationController transformationController =
      TransformationController();

  toPinCreateWidget() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PinCreateWidget(
                  memoryId: widget.memoryId,
                  user: widget.user,
                )));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.memoryId);
    return Scaffold(
      appBar: AppBar(title: const Text("Воспоминания")),
      body: InteractiveViewer(
        constrained: false,
        transformationController: transformationController,
        child: SizedBox(
          width: 2000,
          height: 2000,
          child: Stack(
            children: [
              ...List.generate(
                context.watch<MemoriesProvider>().memory.pins.length,
                (index) => PinWidget(
                  pin: context.watch<MemoriesProvider>().memory.pins[index],
                  memory: context.watch<MemoriesProvider>().memory,
                  user: widget.user,
                  transformationController: transformationController,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => toPinCreateWidget(),
          label: const Text("Создать новую запись"),
          icon: const Icon(Icons.add)),
    );
  }
}

class PinWidget extends StatefulWidget {
  final Pin pin;
  final Memory memory;
  final User user;
  final TransformationController transformationController;
  const PinWidget(
      {Key? key,
      required this.pin,
      required this.memory,
      required this.user,
      required this.transformationController})
      : super(key: key);

  @override
  State<PinWidget> createState() => _PinWidgetState();
}

class _PinWidgetState extends State<PinWidget> {
  deletePin() {
    context
        .read<MemoriesProvider>()
        .deletePin(widget.memory.id, widget.pin.id, widget.user);
  }

  @override
  Widget build(BuildContext context) {
    double addX = widget.transformationController.value.row0.a;
    double addY = widget.transformationController.value.row1.a;
    double appBarHeight = 60;
    double scaleFactor = widget.transformationController.value.row0[0];

    return Positioned(
      top: widget.pin.y,
      left: widget.pin.x,
      child: Draggable(
        onDragEnd: (dragDetails) {
          context.read<MemoriesProvider>().updatePin(
              PinPost(
                  x: (dragDetails.offset.dx - addX) / scaleFactor,
                  y: (dragDetails.offset.dy - addY - appBarHeight) /
                      scaleFactor,
                  name: widget.pin.name,
                  image: widget.pin.image),
              widget.memory.id,
              widget.pin.id,
              widget.user);
        },
        feedback: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Material(
            child: Container(
              padding: const EdgeInsets.all(10),
              constraints: BoxConstraints(
                  maxHeight: widget.pin.image.length > 2 ? 226 : 76,
                  minHeight: 50,
                  maxWidth: 500,
                  minWidth: 100),
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Text(widget.pin.name),
                  if (widget.pin.image.length > 2)
                    SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.memory(base64Decode(widget.pin.image),
                            fit: BoxFit.contain)),
                  IconButton(
                      onPressed: () => deletePin(), icon: Icon(Icons.close))

                ],
              ),
            ),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Material(
            child: Container(
              padding: const EdgeInsets.all(10),
              constraints: BoxConstraints(
                  maxHeight: widget.pin.image.length > 2 ? 226 : 76,
                  minHeight: 50,
                  maxWidth: 500,
                  minWidth: 100),
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Text(widget.pin.name),
                  if (widget.pin.image.length > 2)
                    SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.memory(base64Decode(widget.pin.image),
                            fit: BoxFit.contain)),
                  IconButton(
                      onPressed: () => deletePin(), icon: Icon(Icons.close))

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
