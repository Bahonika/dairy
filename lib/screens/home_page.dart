import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dairy/screens/aims.dart';
import 'package:dairy/screens/memories.dart';
import 'package:dairy/screens/dairy.dart';
import 'package:dairy/screens/dreams.dart';
import 'package:dairy/screens/ideas.dart';
import 'package:dairy/screens/inspirers/inspirers.dart';
import 'package:dairy/main_menu_button.dart';
import 'package:dairy/screens/login_page.dart';
import 'package:dairy/screens/qa/qa.dart';

import '../entities/get_enitites/user.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double borderRadius = 20;

  void logout(BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    widget.user.clear(prefs);
    popBack();
  }

  popBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double padding = MediaQuery.of(context).size.width * 0.03;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => logout(context),
          icon: const Icon(Icons.logout),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QA(user: widget.user, isStarting: false,)));
              },
              icon: const Icon(Icons.person))
        ],
        title: const Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text("Дневник мечты"),
        ),
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        height: height,
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: padding,
            runSpacing: padding,
            runAlignment: WrapAlignment.center,
            children: [
              MainMenuButton(
                text: "Цели",
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(borderRadius)),
                navigateTo: Aims(user: widget.user),
              ),
              MainMenuButton(
                text: "Мечты",
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(borderRadius)),
                navigateTo: Dreams(user: widget.user as AuthorizedUser),
              ),
              MainMenuButton(
                text: "Идеи",
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(borderRadius),
                    bottomRight: Radius.circular(borderRadius)),
                navigateTo: Ideas(user: widget.user as AuthorizedUser),
              ),
              MainMenuButton(
                text: "Дневник",
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    bottomLeft: Radius.circular(borderRadius)),
                navigateTo: Dairy(user: widget.user),
              ),
              MainMenuButton(
                text: "Вдохновители",
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(borderRadius)),
                navigateTo: Inspirers(user: widget.user as AuthorizedUser),
              ),
              MainMenuButton(
                  text: "Воспоминания",
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(borderRadius)),
                  navigateTo: Memories(user: widget.user as AuthorizedUser)),
            ],
          ),
        ),
      ),
    );
  }
}
