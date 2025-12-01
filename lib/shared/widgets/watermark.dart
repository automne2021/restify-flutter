import 'package:flutter/material.dart';
import 'package:restify_flutter/core/constants/app_assets.dart';

class Watermark extends StatelessWidget {
  final Widget child;

  const Watermark({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Screen
        child,

        // Watermark
        Positioned.fill(
          child: IgnorePointer(
              child: Center(
                child: Image.asset(
                  AppAssets.watermark,
                  width: 414,
                  fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}