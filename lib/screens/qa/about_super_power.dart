import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutSuperPower extends StatefulWidget {
  const AboutSuperPower({Key? key}) : super(key: key);

  @override
  State<AboutSuperPower> createState() => _AboutSuperPowerState();
}

class _AboutSuperPowerState extends State<AboutSuperPower> {
  TextEditingController superPower = TextEditingController();
  saveData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("superPower", superPower.text);
  }

  getData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    superPower.text = sharedPreferences.getString("superPower") ?? "";
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
              color: Colors.blue,
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
                "Какая твоя суперсила?",
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
                    controller: superPower,
                    minLines: 5,
                    maxLines: 9,
                    onChanged: (string) => saveData(),
                    decoration: const InputDecoration(
                        label: Text("Выдели свои сильные стороны")),
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
