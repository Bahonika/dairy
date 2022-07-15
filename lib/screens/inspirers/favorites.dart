import 'package:flutter/material.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/screens/inspirers/list_inspirers_widget.dart';
import 'package:dairy/screens/inspirers/list_themes_widget.dart';

class Favorites extends StatefulWidget {
  final User user;
  const Favorites({Key? key, required this.user}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ListInspirersWidget()),
        Expanded(child: ListThemesWidgets(user: widget.user,))
      ],
    );
  }
}
