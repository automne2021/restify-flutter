import 'package:restify_flutter/core/constants/app_assets.dart';

class Model3DItem {
  final String name;
  final String path;
  Model3DItem({required this.name, required this.path});
}

class ModelCategory {
  final String title;
  final String iconAsset;
  final List<Model3DItem> items;

  ModelCategory({
    required this.title,
    required this.iconAsset,
    required this.items,
  });
}

final List<ModelCategory> modelCategories = [
  ModelCategory(
    title: "Inner Peace",
    iconAsset: AppAssets.iconPeace,
    items: [
      Model3DItem(name: "Singing Nepali Bowl", path: "assets/models/singing_nepali_bowl.glb"),
      Model3DItem(name: "Hand Pan", path: "assets/models/handpan.glb"),
      Model3DItem(name: "Kalimba", path: "assets/models/kalimba.glb"),
      Model3DItem(name: "Meditation", path: "assets/models/buddha.glb"),
    ],
  ),
  ModelCategory(
    title: "Vietnam Essence",
    iconAsset: AppAssets.iconVn,
    items: [
      Model3DItem(name: "Ao Dai", path: "assets/models/ao_dai.glb"),
      Model3DItem(name: "Pho", path: "assets/models/pho.glb"),
      Model3DItem(name: "Conical Hat", path: "assets/models/conical_hat.glb"),
      Model3DItem(name: "Dong Son Bronze Drum" , path: "assets/models/drum.glb"),
      Model3DItem(name: "Monochord", path: "assets/models/monochord.glb"),
      Model3DItem(name: "Xa Xi", path: "assets/models/xaxi.glb"),
    ],
  ),
];
