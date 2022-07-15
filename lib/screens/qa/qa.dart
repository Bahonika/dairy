import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/screens/home_page.dart';
import 'package:dairy/screens/qa/about_not_done.dart';
import 'package:dairy/screens/qa/about_some_questions.dart';
import 'package:dairy/screens/qa/about_super_power.dart';
import 'package:dairy/screens/qa/about_you.dart';
import 'package:dairy/screens/qa/about_your_dreams.dart';

class QA extends StatefulWidget {
  final bool isStarting;
  final User user;
  const QA({Key? key, required this.user, required this.isStarting}) : super(key: key);

  @override
  State<QA> createState() => _QAState();
}

class _QAState extends State<QA> {
  LiquidController liquidController = LiquidController();
  bool isEntered = false;

  setEntered() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isEntered", true);
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isEntered = sharedPreferences.getBool("isEntered") ?? false;
    if (isEntered && widget.isStarting) {
      toHomePage();
    }
  }

  toHomePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WillPopScope(
                onWillPop: () async => false,
                child: HomePage(
                  user: widget.user,
                ))));
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 30,
            bottom: 20,
            child: FloatingActionButton(
              heroTag: 'back',
              onPressed: () {
                liquidController.jumpToPage(
                    page: liquidController.currentPage - 1);
                setState(() {});
              },
              child: const Icon(
                Icons.navigate_before_rounded,
                size: 40,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton(
              heroTag: 'next',
              onPressed: () {
                if (liquidController.currentPage == 4) {
                  setEntered();
                  toHomePage();
                } else {
                  liquidController.jumpToPage(
                      page: liquidController.currentPage + 1);
                }
                setState(() {});
              },
              child: Icon(
                liquidController.currentPage == 4
                    ? Icons.done
                    : Icons.navigate_next_rounded,
                size: 40,
              ),
            ),
          ),
          // Add more floating buttons if you want
          // There is no limit
        ],
      ),
      body: LiquidSwipe(
          enableLoop: false,
          liquidController: liquidController,
          pages: const [
            AboutSomeQuestions(),
            AboutSuperPower(),
            AboutYourDreams(),
            AboutYou(),
            AboutNotDone(),
          ]),
    );
  }
}
