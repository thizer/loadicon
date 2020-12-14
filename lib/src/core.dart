import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoadingIcon extends StatefulWidget {
  LoadingIcon({
    Key key,
    this.icon,
    this.duration,
    this.curve,
  }) : super(key: key);

  final Icon icon;
  final Duration duration;
  final Curve curve;

  @override
  _LoadingIconState createState() => _LoadingIconState();
}

class _LoadingIconState extends State<LoadingIcon> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? Duration(seconds: 1),
    );

    super.initState();

    // Start the animation right after this widget finish build action
    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.forward(from: 0.0);
      controller.repeat();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: widget.curve ?? Curves.decelerate,
        ),
      ),
      child: widget.icon ?? Icon(Icons.refresh, size: 12),
    );
  }
}
