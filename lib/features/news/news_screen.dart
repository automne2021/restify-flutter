import 'package:flutter/material.dart';
import 'package:restify_flutter/core/theme/app_colors.dart';
import 'package:restify_flutter/shared/widgets/watermark.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: Watermark(
        child: SafeArea(
          child: Text(
            "News Screen Content",
            style: TextStyle(fontSize: 18, color: kColorGray),
          ),
        ),
      ),
    );
  }
}
