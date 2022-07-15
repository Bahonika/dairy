import 'package:flutter/material.dart';

class MainMenuButton extends StatefulWidget {
  final BorderRadius? borderRadius;
  final String text;
  final Widget navigateTo;

  const MainMenuButton(
      {Key? key,
        this.borderRadius,
        required this.text,
        required this.navigateTo})
      : super(key: key);

  @override
  State<MainMenuButton> createState() => _MainMenuButtonState();
}

class _MainMenuButtonState extends State<MainMenuButton> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double padding = MediaQuery.of(context).size.width * 0.03;

    double side = MediaQuery.of(context).size.width < 450 ? (width - padding * 3) / 2 : 200;

    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => widget.navigateTo)),
      child: Container(

        decoration: BoxDecoration(
          color: const Color.fromRGBO(251, 149, 159, 1),
          borderRadius: widget.borderRadius,
        ),
        height: side,
        width: side,
        child: Center(
          child: Hero(
            tag: widget.text,
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
