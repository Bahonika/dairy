import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutSomeQuestions extends StatefulWidget {
  const AboutSomeQuestions({Key? key}) : super(key: key);

  @override
  State<AboutSomeQuestions> createState() => _AboutSomeQuestionsState();
}

class _AboutSomeQuestionsState extends State<AboutSomeQuestions> {
  TextEditingController knowledge = TextEditingController();
  TextEditingController learning = TextEditingController();
  TextEditingController receive = TextEditingController();

  saveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("knowledge", knowledge.text);
    sharedPreferences.setString("learning", learning.text);
    sharedPreferences.setString("receive", receive.text);
  }

  getData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    knowledge.text = sharedPreferences.getString("knowledge" ) ?? "";
    learning.text = sharedPreferences.getString("learning" ) ?? "";
    receive.text = sharedPreferences.getString("receive") ?? "";
  }

  @override
  void initState() {
getData();    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              color: Colors.red,
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
                    "Прежде чем что-то сделать, спроси себя зачем",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.5),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    controller: knowledge,
                    onChanged: (str) => saveData(),

                    decoration:
                    const InputDecoration(label: Text("Что я хочу узнать")),
                  ),
                  TextFormField(
                    controller: learning,
                    onChanged: (str) => saveData(),
                    decoration: const InputDecoration(
                        label: Text("Чему я хочу научиться")),
                  ),
                  TextFormField(
                    controller: receive,
                    onChanged: (str) => saveData(),

                    decoration: const InputDecoration(
                        label: Text("Что я хочу получить")),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
