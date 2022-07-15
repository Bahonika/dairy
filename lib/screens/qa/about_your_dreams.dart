import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dairy/screens/drawing/drawing_page.dart';

class AboutYourDreams extends StatefulWidget {
  const AboutYourDreams({Key? key}) : super(key: key);

  @override
  State<AboutYourDreams> createState() => _AboutYourDreamsState();
}

class _AboutYourDreamsState extends State<AboutYourDreams> {
  List<String> images = [];

  saveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("images", images);
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    images = sharedPreferences.getStringList("images") ?? [];
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
              color: Colors.greenAccent,
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
                "Нарисуй свою мечту",
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
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          String image = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DrawingPage()));
                          setState(() {
                            images.add(image);
                            saveData();
                          });
                        },
                        child: const Text("Нажми сюда, чтобы нарисовать")),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Stack(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Image.memory(
                                        base64Decode(images[index]),
                                        fit: BoxFit.contain,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: () {
                                              images.removeAt(index);
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.close)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
