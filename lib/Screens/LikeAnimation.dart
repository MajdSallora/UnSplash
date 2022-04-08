import 'package:flutter/material.dart';

class AnimationButtonLike extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final int selectedindex;
  final int index;

  AnimationButtonLike(
      {Key? key,
      required this.child,
      required this.isAnimating,
      this.duration = const Duration(milliseconds: 150),
      required this.onEnd,
      required this.index,
      required this.selectedindex})
      : super(key: key);

  @override
  _AnimationButtonLikeState createState() => _AnimationButtonLikeState();
}

class _AnimationButtonLikeState extends State<AnimationButtonLike>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    final halfDuration = widget.duration.inMilliseconds ~/ 2;

    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(microseconds: halfDuration));
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(AnimationButtonLike oldwidget) {
    if (widget.isAnimating != oldwidget.isAnimating) {
      doAnimation();
    }
    super.didUpdateWidget(oldwidget);
  }

  Future doAnimation() async {
    await controller.forward();
    await controller.reverse();
    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    if (widget.onEnd != null) {
      widget.onEnd!();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: scale,
        child: widget.selectedindex == widget.index ? widget.child : null);
  }
}
