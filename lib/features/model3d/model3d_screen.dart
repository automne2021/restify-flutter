import 'package:flutter/material.dart';
import 'package:restify_flutter/core/theme/app_colors.dart';

class Model3DScreen extends StatelessWidget {
  const Model3DScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBlack,
      body: SafeArea(
        child: Text(
          "3D Model Viewer Here",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}