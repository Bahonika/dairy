import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/theme.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/providers/self_info_provider.dart';

class ThemeWidget extends StatefulWidget {
  final ThemeEntity theme;
  final User user;
  const ThemeWidget({Key? key, required this.theme, required this.user}) : super(key: key);

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    for (ThemeEntity theme
        in context.watch<SelfInfoProvider>().selfInfo.themes) {
      if (theme.id == widget.theme.id) {
        isFavorite = true;
      }
    }

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.amberAccent),
      width: 20,
      child: Row(
        children: [
          Text(widget.theme.name),
          IconButton(
              onPressed: () {
                if (isFavorite){
                  print("Было любимым");
                  context.read<SelfInfoProvider>().deleteFavorite(widget.user, widget.theme.id);
                } else {
                  print("Не было");
                  context.read<SelfInfoProvider>().setFavorite(widget.user, widget.theme.id);
                }
              },
              icon: isFavorite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border_outlined))
        ],
      ),
    );
  }
}
