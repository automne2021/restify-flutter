import 'package:flutter/material.dart';
import 'package:restify_flutter/core/theme/app_colors.dart';

class HomeFeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final String buttonText;
  final Color backgroundColor;
  final VoidCallback onTap;

  const HomeFeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.buttonText,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 177,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ]
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            top: 0,

            child: SizedBox(
              width: 120,
              height: 94,
              child: Image.asset(
                imageAsset,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, size: 50, color: kColorOrange),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 97),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 18, height: 1.2),
                ),
                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Subtitle
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: kColorGray,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        letterSpacing: 11 * 0.05,
                      ),
                    ),

                    // START button
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: kColorBlack,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            color: kColorCream,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
