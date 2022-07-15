import 'package:flutter/material.dart';

typedef AcceptCallback = void Function(dynamic data);

class BarTarget<T> extends StatefulWidget {
  final double width;
  final double height;
  final Color color;
  final Widget child;
  final AcceptCallback onAccept;

  const BarTarget(
      {Key? key,
      required this.width,
      required this.height,
      required this.color,
      required this.child,
      required this.onAccept})
      : super(key: key);

  @override
  State<BarTarget> createState() => BarTargetState<T>();
}

class BarTargetState<T> extends State<BarTarget> with TickerProviderStateMixin {
   AnimationController? _controller;
   Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _animation = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .animate(_controller!);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller!.forward();
    return DragTarget<Object>(
      onWillAccept: (data) => true,
      onAccept: widget.onAccept,

      /// The animation makes the Bar slide in from the bottom
      builder: (context, candidateData, rejectedData) => AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) => SlideTransition(
          position: _animation!,
          child: child,
        ),
        child: Container(
          width: widget.width,
          height: widget.height,
          color: widget.color,
          child: widget.child,
        ),
      ),
    );
  }
}
