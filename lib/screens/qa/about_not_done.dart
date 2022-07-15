import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutNotDone extends StatefulWidget {
  const AboutNotDone({Key? key}) : super(key: key);

  @override
  State<AboutNotDone> createState() => _AboutNotDoneState();
}

class _AboutNotDoneState extends State<AboutNotDone> {
  List<TextEditingController> textEditingControllers = [];
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController controller7 = TextEditingController();
  TextEditingController controller8 = TextEditingController();
  TextEditingController controller9 = TextEditingController();
  TextEditingController controller10 = TextEditingController();

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    for (int i = 0; i < 10; i++) {
      textEditingControllers[i].text =
          sharedPreferences.getString("notDone${i + 1}") ?? "";
    }
    setState(() {});
  }

  @override
  void initState() {
    textEditingControllers = [
      controller1,
      controller2,
      controller3,
      controller4,
      controller5,
      controller6,
      controller7,
      controller8,
      controller9,
      controller10,
    ];
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
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 5,
              color: Colors.white,
              child: const Center(
                  child: Text(
                "10 вещей, которые я хотел сделать, но почему то не сделал",
                style: TextStyle(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              )),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.9),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 2,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        MyTextFromField(
                          textEditingController: controller1,
                          label: "1",
                        ),
                        MyTextFromField(
                          textEditingController: controller2,
                          label: "2",
                        ),
                        MyTextFromField(
                          textEditingController: controller3,
                          label: "3",
                        ),
                        MyTextFromField(
                          textEditingController: controller4,
                          label: "4",
                        ),
                        MyTextFromField(
                          textEditingController: controller5,
                          label: "5",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      MyTextFromField(
                        textEditingController: controller6,
                        label: "6",
                      ),
                      MyTextFromField(
                        textEditingController: controller7,
                        label: "7",
                      ),
                      MyTextFromField(
                        textEditingController: controller8,
                        label: "8",
                      ),
                      MyTextFromField(
                        textEditingController: controller9,
                        label: "9",
                      ),
                      MyTextFromField(
                        textEditingController: controller10,
                        label: "10",
                      ),
                    ],
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyTextFromField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  const MyTextFromField({
    Key? key,
    required this.textEditingController,
    required this.label,
  }) : super(key: key);

  saveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("notDone$label", textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white38),
      child: TextFormField(
        controller: textEditingController,
        onChanged: (string) => saveData(),
        decoration: InputDecoration(
          label: Text(label),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
