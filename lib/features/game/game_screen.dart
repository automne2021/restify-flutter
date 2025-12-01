import 'package:flutter/material.dart';
import 'package:restify_flutter/core/theme/app_colors.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBlack,
      body: SafeArea(
        child: Text(
          "Game Screen Content",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}