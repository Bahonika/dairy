import 'package:flutter/material.dart';
import 'package:dairy/entities/get_enitites/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      width: 20,
      child: Text(post.name),
    );
  }
}