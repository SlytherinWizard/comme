import 'dart:ui';

import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final Color color;

  const BlurContainer({
    Key? key,
    required this.child,
    this.blur = 5.0,
    this.color = Colors.white54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(color: color, child: child),
      ),
    );
  }
}
