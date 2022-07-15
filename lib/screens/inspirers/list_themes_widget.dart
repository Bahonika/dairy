import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/providers/theme_provider.dart';
import 'package:dairy/screens/inspirers/theme_widget.dart';

class ListThemesWidgets extends StatelessWidget {
  final User user;
  const ListThemesWidgets({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white38),
      child: ListView.builder(
          itemCount: context.watch<ThemeProvider>().themes.length,
          controller: ScrollController(),
          itemBuilder: (context, index) {
            return ThemeWidget(
              theme: context.watch<ThemeProvider>().themes[index], user: user,
            );
          }),
    );
  }
}