import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:restify_flutter/core/constants/app_strings.dart';
import 'package:restify_flutter/core/constants/app_assets.dart';
import 'package:restify_flutter/core/theme/app_colors.dart';

import 'package:restify_flutter/features/info/widgets/info_dropdown_item.dart';
import 'package:restify_flutter/shared/widgets/app_logo.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // --- BACK ICON ---
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(50),
                    child: SvgPicture.asset(
                      AppAssets.iconBack,
                      width: 40,
                      height: 40,
                    ),
                  ),

                  // --- LOGO ---
                  const AppLogo(width: 99),

                  // Right fake space
                  const SizedBox(width: 40),
                ],
              ),
            ),

            const SizedBox(height: 11),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: const [
                  // DROPDOWN 1: About Us
                  InfoDropdownItem(
                    title: "About Us",
                    content: AppStrings.aboutUs,
                  ),

                  // DROPDOWN 2: Terms of Service
                  InfoDropdownItem(
                    title: "Terms of Service",
                    content: AppStrings.termsOfService,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
