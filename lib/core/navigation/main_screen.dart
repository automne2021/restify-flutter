//Contains Scaffold with BottomNavigationBar
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:restify_flutter/core/theme/app_colors.dart';
import 'package:restify_flutter/core/constants/app_assets.dart';
import 'package:restify_flutter/core/navigation/widgets/nav_active_button.dart';

import 'package:restify_flutter/features/home/home_screen.dart';
import 'package:restify_flutter/features/news/news_screen.dart';
import 'package:restify_flutter/features/video/video_screen.dart';
import 'package:restify_flutter/features/model3d/model3d_screen.dart';
import 'package:restify_flutter/features/game/game_screen.dart';

// Use StatefulWidget to store the selected tab index"
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Tab Home

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Screens list
  List<Widget> get _screens => [
    HomeScreen(
      onSwitchTab: (index) {
        _onItemTapped(index);
      },
    ),
    const NewsScreen(),
    const VideoScreen(),
    const Model3DScreen(),
    const GameScreen(),
  ];

  BottomNavigationBarItem _buildNavItem(String assetPath, String label) {
    return BottomNavigationBarItem(
      // Icon Inactive
      icon: Container(
        width: 46, height: 46,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: SvgPicture.asset(
          assetPath,
          width: 22,
          height: 22,
          colorFilter: const ColorFilter.mode(kColorGray, BlendMode.srcIn),
        ),
      ),

      // Icon Active
      activeIcon: NavActiveIcon(assetPath: assetPath),

      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Show the selected screen
      body: IndexedStack(index: _selectedIndex, children: _screens),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        // height: 112,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 17,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: kColorOrange,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            unselectedItemColor: kColorGray,
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showSelectedLabels: true,
            showUnselectedLabels: true,

            items: <BottomNavigationBarItem>[
              _buildNavItem(AppAssets.iconHome, 'Home'),
              _buildNavItem(AppAssets.iconNews, 'News'),
              _buildNavItem(AppAssets.iconVideo, 'Video'),
              _buildNavItem(AppAssets.icon3d, '3D'),
              _buildNavItem(AppAssets.iconGame, 'Game'),
            ],
          ),
        ),
      ),
    );
  }
}
