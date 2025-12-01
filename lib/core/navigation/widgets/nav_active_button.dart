import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restify_flutter/core/theme/app_colors.dart';

class NavActiveIcon extends StatelessWidget {
  final String assetPath;

  const NavActiveIcon({
    super.key,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kColorOrange,
        borderRadius: BorderRadius.circular(18),
      ),
      child: SvgPicture.asset(
        assetPath,
        width: 22,
        height: 22,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }
}