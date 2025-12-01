import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:restify_flutter/core/theme/app_colors.dart';
import 'package:restify_flutter/core/constants/app_assets.dart';

import 'package:restify_flutter/shared/widgets/app_markdown.dart';

class InfoDropdownItem extends StatefulWidget {
  final String title;
  final String content;

  final String? iconAsset;

  const InfoDropdownItem({
    super.key,
    required this.title,
    required this.content,
    this.iconAsset,
  });

  @override
  State<InfoDropdownItem> createState() => _InfoDropdownItemState();
}

class _InfoDropdownItemState extends State<InfoDropdownItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374,
      margin: const EdgeInsets.only(bottom: 28),
      child: Card(
        color: kColorBeige,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        clipBehavior: Clip.hardEdge,

        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 25,
            ),

            onExpansionChanged: (bool expanded) {
              setState(() => _isExpanded = expanded);
            },

            title: Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorBlack,
                fontSize: 18,
              ),
            ),

            // Custom trailing icon
            trailing: AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: SvgPicture.asset(
                AppAssets.iconCircleDown,
                width: 40,
                height: 40,
              ),
            ),

            children: [
              Container(
                padding: const EdgeInsets.all(30),
                color: kColorWhite,
                width: double.infinity,
                child: AppMarkdown(
                  data: widget.content, // Nội dung từ AppStrings
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
