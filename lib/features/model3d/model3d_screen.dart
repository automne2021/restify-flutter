import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:restify_flutter/core/constants/app_assets.dart';

import 'package:restify_flutter/core/theme/app_colors.dart';
import 'package:restify_flutter/features/model3d/data/model_data.dart';

class Model3DScreen extends StatefulWidget {
  const Model3DScreen({super.key});

  @override
  State<Model3DScreen> createState() => _Model3DScreenState();
}

class _Model3DScreenState extends State<Model3DScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Model3DItem _selectedModel;

  @override
  void initState() {
    super.initState();
    _selectedModel = modelCategories[0].items[0];
  }

  // Change selected model
  void _onSelectModel(Model3DItem item) {
    setState(() {
      _selectedModel = item;
    });
    Navigator.pop(context); // Close Drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kColorBlack,

      // --- MENU (DRAWER) ---
      drawer: Drawer(
        backgroundColor: kColorWhite,
        width: MediaQuery.of(context).size.width * 0.75,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Dropdown (Accordion)
              Expanded(
                child: ListView.builder(
                  itemCount: modelCategories.length,
                  itemBuilder: (context, index) {
                    final category = modelCategories[index];

                    return Theme(
                      data: ThemeData().copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        shape: const Border(),
                      collapsedShape: const Border(),
                      leading: SvgPicture.asset(category.iconAsset, width: 24, height: 24),
                      title: Text(
                        category.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kColorBlack,
                        ),
                      ),
                      collapsedIconColor: kColorGray,
                      childrenPadding: const EdgeInsets.only(left: 20),

                      // Model items list
                      children: category.items.map((item) {
                        final isSelected = item.path == _selectedModel.path;
                        return ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          title: Text(
                            item.name,
                            style: TextStyle(
                              color: isSelected ? kColorOrange : kColorBlack,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),

                          onTap: () => _onSelectModel(item),
                        );
                      }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // --- VIEWER ---
      body: SafeArea(
        child: Stack(
          children: [
            // 1. MODEL VIEWER
            ModelViewer(
              key: ValueKey(_selectedModel.path),
              src: _selectedModel.path,
              alt: "A 3D model of ${_selectedModel.name}",
              ar: true,
              autoRotate: true,
              cameraControls: true,
              backgroundColor: Colors.transparent,
              loading: Loading.eager,
            ),

            // 2. MENU BUTTON
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: SvgPicture.asset(AppAssets.iconMenu, width: 30, height: 24),
                  ),
                ],
              ),
            ),

            // 3. INSTRUCTION TEXT
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: kColorBlack,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: kColorCream),
                  ),
                  child: const Text(
                    "Drag to rotate  •  Pinch to rotate",
                    style: TextStyle(color: kColorCream, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}