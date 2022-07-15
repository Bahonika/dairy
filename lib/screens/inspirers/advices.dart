import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Advices extends StatefulWidget {
  const Advices({Key? key}) : super(key: key);

  @override
  State<Advices> createState() => _AdvicesState();
}

class _AdvicesState extends State<Advices> {
  // VideoPlayerController videoPlayerController = VideoPlayerController.network(
  //     "https://www.youtube.com/watch?v=VHy0SVAqgvE");

  List<String> advices = [
    "Не забывайте мечтать – так развивается воображение, а это способствует появлению вдохновения",
    "Путешествуйте или просто прогуляйтесь по улице – это помогает черпать вдохновение из окружающих пейзажей",
    "Читайте книги – интересные мысли помогут начать творить",
    "Помните о саморазвитии – это могут быть не только книги, но и фильмы, спектакли, выставки, форумы или конференции",
    "Общайтесь с людьми – вдохновение и рабочий настрой других может легко передаться и вам",
    "Верьте в себя и цените свои сильные стороны – это залог успешного результата",
    "Не забывайте о позитивном настрое и хорошем настроении – это важно для творческих личностей",
    "Слушайте свой организм, не забывайте об отдыхе, полноценном питании и крепком сне",
  ];

  @override
  void initState() {
    // TODO проблема отображения видео в web
    // videoPlayerController.initialize().then((value) => setState(() {}));
    // videoPlayerController.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: advices.length,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(10),
          child: Text(
                advices[index],
                style: const TextStyle(
                  color: Color.fromRGBO(250, 220, 146, 1),
                  fontSize: 30,
                ),
              ),
        ));
  }
}
