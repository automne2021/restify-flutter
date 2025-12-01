import 'dart:async';
import 'package:flutter/material.dart';

import 'package:restify_flutter/core/constants/app_assets.dart';
import 'package:restify_flutter/core/theme/app_colors.dart';

import 'package:restify_flutter/features/welcome/welcome_screen.dart';
import 'package:restify_flutter/shared/widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _navigateToNextScreen() {
    // Wait for 2000 milliseconds
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        // Navigate to WelcomeScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorCream,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Image.asset(
            AppAssets.splashBg,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: kColorCream);
            },
          ),

          // LOGO
          Center(child: AppLogo(width: 264, height: 38)),
        ],
      ),
    );
  }
}
