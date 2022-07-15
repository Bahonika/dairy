import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dairy/providers/dreams_provider.dart';
import 'package:dairy/providers/memories_provider.dart';
import 'package:dairy/providers/note_provider.dart';
import 'package:dairy/providers/self_info_provider.dart';
import 'package:dairy/screens/login_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:dairy/screens/qa/qa.dart';

import 'entities/get_enitites/user.dart';
import 'providers/aims_provider.dart';
import 'providers/post_provider.dart';
import 'providers/tasks_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';

void main() {
  initializeDateFormatting();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => TasksProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => AimsProvider()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => PostProvider()),
    ChangeNotifierProvider(create: (_) => DreamsProvider()),
    ChangeNotifierProvider(create: (_) => SelfInfoProvider()),
    ChangeNotifierProvider(create: (_) => MemoriesProvider()),
    ChangeNotifierProvider(create: (_) => NoteProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Дневник мечты',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(24, 2, 60, 1),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintStyle: TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(131, 60, 189, 1),
          secondary: const Color.fromRGBO(251, 149, 159, 1),
        ),
      ),
      home: const Redirection(),
    );
  }
}

// The statefulWidget class required for redirecting to the gallery page if the user was logged in earlier.
class Redirection extends StatefulWidget {
  const Redirection({Key? key}) : super(key: key);

  @override
  State<Redirection> createState() => _RedirectionState();
}

class _RedirectionState extends State<Redirection> {
  User? user;

  restoreUser() async {
    var prefs = await SharedPreferences.getInstance();
    user = await restoreFromSharedPrefs(prefs);
    setState(() {});
  }

  @override
  void initState() {
    restoreUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Image.memory(base64Decode("iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAIAAACQd1PeAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAMSURBVBhXY/j//z8ABf4C/qc1gYQAAAAASUVORK5CYII="));
    // return QA();
    // return DrawingPage();
    if (user == null) {
      return const LoginPage();
    } else {
      return user!.role != GuestUser().role
          ? QA(
              user: user!,
              isStarting: true,
            )
          : const LoginPage();
    }
  }
}
