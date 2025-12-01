import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:restify_flutter/core/constants/app_assets.dart';
import 'package:restify_flutter/core/theme/app_colors.dart';
import 'package:restify_flutter/shared/widgets/app_logo.dart';

import 'package:restify_flutter/features/home/widgets/home_feature_card.dart';
import 'package:restify_flutter/features/home/widgets/home_banner_card.dart';
import 'package:restify_flutter/features/info/info_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onSwitchTab;

  const HomeScreen({
    super.key,
    required this.onSwitchTab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header: logo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  const AppLogo(width: 99),

                  // Info button
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const InfoScreen(),
                        ),
                      );
                    },
                    icon: SvgPicture.asset(
                      AppAssets.iconInfo,
                      width: 30,
                      height: 30,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 48,
                      minHeight: 48,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 51),

              // 2. Greeting Section
              Text(
                'Rest, chief!',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 28,
                  color: kColorBlack,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Hope your day's going well",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: kColorGray,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 45),

              // 3. Feature Cards (News & Video)
              Row(
                children: [
                  // News
                  Expanded(
                    child: HomeFeatureCard(
                      title: 'Breaking News',
                      subtitle: 'READ NOW',
                      imageAsset: AppAssets.homeNews,
                      buttonText: 'START',
                      backgroundColor: kColorBeige,
                      onTap: () {
                        onSwitchTab(1);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Video
                  Expanded(
                    child: HomeFeatureCard(
                      title: 'Watch Videos',
                      subtitle: 'WATCH NOW',
                      imageAsset: AppAssets.homeVideo,
                      buttonText: 'START',
                      backgroundColor: kColorBeige,
                      onTap: () {
                        onSwitchTab(2);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // 4. Banner 3D Models
              HomeBannerCard(
                title: '3D Models',
                subtitle: 'PLAY NOW',
                color: kColorOrange,
                icon: AppAssets.iconCircleRight,
                onTap: () {
                  onSwitchTab(3);
                },
              ),

              const SizedBox(height: 30),

              // 5. Section Title: Game on!
              Text(
                'Game on!',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 16),

              // 6. Banner Game
              HomeBannerCard(
                title: 'Tic Tac Toe',
                subtitle: 'PLAY NOW',
                color: kColorOrange,
                icon: AppAssets.iconCircleRight,
                onTap: () {
                  onSwitchTab(4);
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
