import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dairy/providers/post_provider.dart';
import 'package:dairy/screens/inspirers/post_widget.dart';

class Ribbon extends StatefulWidget {
  const Ribbon({Key? key}) : super(key: key);

  @override
  State<Ribbon> createState() => _RibbonState();
}

class _RibbonState extends State<Ribbon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      color: Colors.red,
      width: MediaQuery.of(context).size.width * 0.3,
      child: ListView.builder(
          itemCount: context.watch<PostProvider>().posts.length,
          itemBuilder: (context, index) {
            return PostWidget(
              post: context.watch<PostProvider>().posts[index],
            );
          }),
    );
  }
}





