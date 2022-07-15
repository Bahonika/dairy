import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/entities/get_enitites/user.dart';
import 'package:dairy/providers/post_provider.dart';
import 'package:dairy/providers/self_info_provider.dart';
import 'package:dairy/providers/theme_provider.dart';
import 'package:dairy/providers/user_provider.dart';
import 'package:dairy/screens/create_widgets/post_create_widget.dart';
import 'package:dairy/screens/inspirers/advices.dart';
import 'package:dairy/screens/inspirers/favorites.dart';
import 'package:dairy/screens/inspirers/ribbon.dart';

class Inspirers extends StatefulWidget {
  final AuthorizedUser user;

  const Inspirers({Key? key, required this.user}) : super(key: key);

  @override
  State<Inspirers> createState() => _InspirersState();
}

class _InspirersState extends State<Inspirers>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  getData() {
    context.read<ThemeProvider>().getData(widget.user);
    context.read<PostProvider>().getData(widget.user);
    context.read<SelfInfoProvider>().getData(widget.user);
    context.read<UserProvider>().getInsiprers(widget.user);
  }

  @override
  void initState() {
    getData();
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  toPostCreate() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PostCreateWidget(user: widget.user)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Вдохновители"),
        leading: const BackButton(),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Icon(Icons.border_color_outlined),
            Icon(Icons.list),
            Icon(Icons.favorite)
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Advices(),
          Ribbon(),
          Favorites(
            user: widget.user,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: toPostCreate, label: const Text("Создать запись")),
    );
  }
}
