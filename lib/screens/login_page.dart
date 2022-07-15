import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/entities/get_repositories/auth_user.dart';
import 'package:dairy/screens/qa/qa.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController loginController;
  late TextEditingController passwordController;

  User? user;
  var authUser = AuthUser();
  bool isAuthFailed = false;

  @override
  void initState() {
    loginController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    try {
      user = await authUser.auth(
          loginController.value.text, passwordController.value.text);
      var prefs = await SharedPreferences.getInstance();
      user!.save(prefs);
      setState(() {
        isAuthFailed = false;
      });
      pushToHomePage();
    } on AuthorizationException {
      setState(() {
        isAuthFailed = true;
      });
    }
  }

  pushToHomePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WillPopScope(
                onWillPop: () async => false,
                child: QA(
                  user: user!,
                  isStarting: true,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Вход"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 300, maxWidth: 600),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).colorScheme.primary,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isAuthFailed)
                    const Text(
                      "Неверные данные пользователя",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  TextField(
                      controller: loginController,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Логин",
                      )),
                  TextField(
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    decoration: const InputDecoration(
                      hintText: "Пароль",
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: login, child: const Text("Вход")),
                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
