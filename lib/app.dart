// App root file, contains MaterialApp setup
import 'package:flutter/material.dart';
import 'package:restify_flutter/core/theme/app_theme.dart';
import 'package:restify_flutter/features/splash/splash_screen.dart';

class RestifyApp extends StatelessWidget {
  const RestifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restify',
      theme: kAppTheme,
      debugShowCheckedModeBanner: false, // turn off debug banner
      home: const SplashScreen(), // start with SplashScreen
    );
  }
}