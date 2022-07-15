import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/self_info.dart';
import 'package:dairy/entities/get_enitites/theme.dart';
import 'package:dairy/providers/user_provider.dart';

class ListInspirersWidget extends StatelessWidget {
  const ListInspirersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: context.watch<UserProvider>().inspirers.length,
        itemBuilder: (context, index) {
          return InspirerWidget(
              userInfo: context.watch<UserProvider>().inspirers[index]);
        });
  }
}

class InspirerWidget extends StatelessWidget {
  final UserInfo userInfo;
  const InspirerWidget({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white38,
      child: ListTile(
        leading: Text(userInfo.username),
        trailing: SizedBox(
          width: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: userInfo.themes.length,
              itemBuilder: (context, index) => ThemeBanner(
                    theme: userInfo.themes[index],
                  )),
        ),
      ),
    );
  }
}

class ThemeBanner extends StatelessWidget {
  final ThemeEntity theme;
  const ThemeBanner({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.amberAccent),
      child: Center(child: Text(theme.name)),
    );
  }
}
