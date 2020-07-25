import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class MyFadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const MyFadeAnimation({this.delay, this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween()
      ..add('opacity', 0.0.tweenTo(1.0), Duration(milliseconds: 500),
          Curves.easeOut)
      ..add('translateY', 130.0.tweenTo(0.0), Duration(milliseconds: 500),
          Curves.easeOut);

    return PlayAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      child: child,
      tween: tween,
      builder: (context, child, animation) {
        return Opacity(
          opacity: animation.get('opacity'),
          child: Transform.translate(
            offset: Offset(0, animation.get('translateY')),
            child: child,
          ),
        );
      },
    );
  }
}
