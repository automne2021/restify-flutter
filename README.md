# Restify (Flutter)

Restify is a cross-platform mobile application designed for relaxation and productivity, built with **Flutter** and **Dart**. This repository contains the source code for the mobile client.

## ⚠️ CRITICAL DEVELOPMENT RULE

To ensure consistency and avoid caching issues during development, please follow this rule strictly:

> **If you modify ANY file inside the `lib/core/` directory** (e.g., `app_assets.dart`, `app_colors.dart`, `app_strings.dart` or Theme configs), you **MUST** execute the following commands in the terminal before running the app again:

```bash
flutter clean
flutter pub get
flutter run
```

**Step 1:** Copy the SDK Path from Android Studio

Open Android Studio.

Go to `More Actions > SDK Manager` (or `File > Settings > Languages & Frameworks > Android SDK`).

Look near the top of the window for a text box labeled "Android SDK Location".

Copy that entire path.

It usually looks like: `C:\Users\YourName\AppData\Local\Android\Sdk`

**Step 2:** Paste it into Flutter

Go back to your terminal (in VS Code or Android Studio).

Run this command, replacing `[YOUR_PATH]` with the path you just copied:

```Bash
flutter config --android-sdk "PASTE_YOUR_PATH_HERE"
```

Example: `flutter config --android-sdk "C:\Users\Admin\AppData\Local\Android\Sdk"`

**Step 3:** Run the License Command Again

Now that Flutter knows where to look, run the license command again:

```Bash
flutter doctor --android-licenses
```

If it asks you to review licenses, keep typing y and hitting Enter until it finishes.

**Step 4:** Verify
Run:

```Bash
flutter devices
```