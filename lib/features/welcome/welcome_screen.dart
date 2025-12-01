import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:restify_flutter/core/theme/app_colors.dart';
import 'package:restify_flutter/core/constants/app_assets.dart';
import 'package:restify_flutter/core/constants/app_strings.dart';
import 'package:restify_flutter/core/navigation/main_screen.dart';
import 'package:restify_flutter/shared/widgets/app_logo.dart';
import 'package:restify_flutter/shared/widgets/app_markdown.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isChecked = false;

  void _onGetStarted() {
    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms of Service.'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        titlePadding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

        title: Row(
          children: [
            const Opacity(
              opacity: 0.0,
              child: IconButton(icon: Icon(Icons.close), onPressed: null),
            ),
            // Header
            const Expanded(
              child: Text(
                "Terms of Service",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kColorBlack,
                ),
              ),
            ),
            // Close button
            IconButton(
              // icon: const Icon(Icons.close),
              icon: SvgPicture.asset(AppAssets.iconX, width: 20, height: 20),
              color: kColorGray,
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),

        content: SizedBox(
          height: 600,
          width: 360,
          child: SingleChildScrollView(
            child: AppMarkdown(
              data: AppStrings.termsOfService,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kColorCream,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ===============================================
          // Img
          // ===============================================
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: size.height * 0.6,
              child: Image.asset(
                AppAssets.welcomeImg,
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
                errorBuilder: (_, __, ___) => Container(
                  color: kColorOrange,
                  height: 300,
                  alignment: Alignment.center,
                  child: const Text("Image Error"),
                ),
              ),
            ),
          ),

          // ===============================================
          // Logo & Text
          // ===============================================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 37),
                  // Logo
                  const AppLogo(width: 99),
                  const SizedBox(height: 114),
                  // Headline
                  Text(
                    'Welcome to Restify!',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: kColorBlack,
                    ),
                  ),
                  const SizedBox(height: 35),
                  // Subtitle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 49),
                    child: Text(
                      'Explore the app, Find some peace of mind.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 16,
                        color: kColorGray,
                        height: 1.125, // 18/16 = 1.125
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===============================================
          // GET STARTED & CHECKBOX
          // ===============================================
          Positioned(
            bottom: 94,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // GET STARTED
                SizedBox(
                  width: double.infinity,
                  height: 63,
                  child: ElevatedButton(
                    onPressed: _onGetStarted,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kColorCream,
                      foregroundColor: kColorBlack,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 14 * 0.05,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 19),

                // Checkbox & Terms
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: _isChecked,
                        onChanged: (val) =>
                            setState(() => _isChecked = val ?? false),
                        side: const BorderSide(color: Colors.white, width: 1),
                        activeColor: Colors.white,
                        checkColor: kColorOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        children: [
                          const TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _showTermsDialog,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Home Indicator spacer
                //const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
