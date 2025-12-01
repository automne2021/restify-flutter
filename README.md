# Restify (Flutter)

Restify is a cross-platform mobile application designed for relaxation and productivity, built with **Flutter** and **Dart**. This repository contains the source code for the mobile client.

## ⚠️ CRITICAL DEVELOPMENT RULE

To ensure consistency and avoid caching issues during development, please follow this rule strictly:

> **If you modify ANY file inside the `lib/core/` directory** (e.g., `app_assets.dart`, `app_colors.dart`, `app_strings.dart` or Theme configs), you **MUST** execute the following commands in the terminal before running the app again:

```bash
flutter clean
flutter pub get
flutter run