import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:restify_flutter/core/theme/app_colors.dart';

class AppMarkdown extends StatelessWidget {
  final String data;

  const AppMarkdown({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: data,

      styleSheet: MarkdownStyleSheet(
        // Normal text
        p: const TextStyle(fontSize: 14, color: kColorBlack, height: 1.5),

        // #
        h1: const TextStyle(
          fontSize: 16,
          color: kColorBlack,
          fontWeight: FontWeight.bold,
        ),

        // ##
        h2: const TextStyle(
          fontSize: 14,
          color: kColorBlack,
          fontWeight: FontWeight.bold,
        ),

        // **text**
        strong: const TextStyle(
          color: kColorBlack,
          fontWeight: FontWeight.w500,
        ),

        listBullet: const TextStyle(color: kColorBlack, fontSize: 14),
      ),
    );
  }
}
