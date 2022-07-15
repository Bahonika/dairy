import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutYou extends StatefulWidget {
  const AboutYou({Key? key}) : super(key: key);

  @override
  State<AboutYou> createState() => _AboutYouState();
}

class _AboutYouState extends State<AboutYou> {
  List<String> characteristics = [
    "Интроверт",
    "Экстраверт",
    "Любознательный",
    "Индивидуалист",
    "Серьезный",
    "Лидер",
  ];

  List<String> chosen = [];

  TextEditingController controller = TextEditingController();

  saveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("chosen", chosen);
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    chosen = sharedPreferences.getStringList("chosen") ?? [];
    for (String chose in chosen) {
      characteristics.remove(chose);
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              color: Colors.yellowAccent,
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.33),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 7,
              color: Colors.white,
              child: const Center(
                  child: Text(
                "Какой ты?",
                maxLines: 20,
                style: TextStyle(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              )),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DragTarget(onAccept: (data) {
                  characteristics.add(data.toString());
                  chosen.remove(data.toString());
                  saveData();
                  setState(() {});
                }, builder: (context, candidateData, rejectedData) {
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width / 2) < 200
                        ? MediaQuery.of(context).size.width / 2.5
                        : 200,
                    height: 300,
                    child: ListView.builder(
                        controller: ScrollController(),
                        itemCount: characteristics.length,
                        itemBuilder: (context, index) => DraggableWidget(
                            name: characteristics[index], color: Colors.red)),
                  );
                }),
                DragTarget(onAccept: (data) {
                  chosen.add(data.toString());
                  characteristics.remove(data.toString());
                  saveData();
                  setState(() {});
                }, builder: (context, candidateData, rejectedData) {
                  return Container(
                    width: (MediaQuery.of(context).size.width / 2) < 200
                        ? MediaQuery.of(context).size.width / 2.5
                        : 200,
                    height: 300,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.greenAccent, width: 5),
                        borderRadius: BorderRadius.circular(26)),
                    child: ListView.builder(
                        controller: ScrollController(),
                        itemCount: chosen.length,
                        itemBuilder: (context, index) => DraggableWidget(
                            name: chosen[index], color: Colors.red)),
                  );
                })
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.8),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white38),
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    label: const Text("Какой ты еще?"),
                    suffix: IconButton(
                      onPressed: () {
                        chosen.add(controller.text);
                        setState(() {});
                      },
                      icon: const Icon(Icons.done),
                    )),
                controller: controller,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DraggableWidget extends StatefulWidget {
  final Color color;
  final String name;
  const DraggableWidget({Key? key, required this.name, required this.color})
      : super(key: key);

  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: widget.name,
      feedback: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Material(
          child: Container(
            width: (MediaQuery.of(context).size.width / 2) < 200
                ? MediaQuery.of(context).size.width / 2.5
                : 200,
            height: 40,
            decoration: BoxDecoration(
                color: widget.color, borderRadius: BorderRadius.circular(100)),
            child: Text(widget.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:
                      (MediaQuery.of(context).size.width / 2) < 200 ? 10 : 20,
                )),
          ),
        ),
      ),
      child: Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
            color: widget.color, borderRadius: BorderRadius.circular(100)),
        child: Text(widget.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: (MediaQuery.of(context).size.width / 2) < 200 ? 15 : 20,
            )),
      ),
    );
  }
}
