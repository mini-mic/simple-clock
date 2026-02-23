# Simple Clock

A minimal, fullscreen digital clock built with Flutter. Designed to look like a classic 7-segment display and keep the screen active while in use.

## Features

- **7-Segment Display:** Uses a custom digital font for a retro feel.
- **Wakelock:** Keeps the device screen from dimming or sleeping while the clock is running.
- **Save State:** Remembers your settings/preferences using `shared_preferences`.
- **Fullscreen Mode:** Clean, distraction-free timekeeping.

## Prerequisites

Before you begin, ensure you have the following installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Targeting SDK ^3.11.0)
- [Dart SDK](https://dart.dev/get-started/sdk)
- **For iOS:** macOS with Xcode installed.
- **For Android:** Android Studio and Android SDK.

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/mini-mic/simple-clock.git
   cd simple-clock
   ```

2. **Accept Android Licenses:**
   This is required before your first Android build.
   ```bash
   flutter doctor --android-licenses
   ```

3. **Install dependencies:**
   This command will also attempt to generate `android/local.properties`.
   ```bash
   flutter pub get
   ```

4. **Troubleshooting local.properties:**
   If the build fails complaining about `local.properties`, create `android/local.properties` and add your SDK path:
   ```properties
   sdk.dir=/Users/YOUR_USERNAME/Library/Android/sdk
   ```

5. **Run the app:**
   ```bash
   flutter run
   ```

## Build Instructions

### iOS
To build the `.ipa` or run on an iOS device:
1. Ensure CocoaPods is installed: `brew install cocoapods`.
2. Install pod dependencies:
   ```bash
   cd ios
   pod install
   cd ..
   ```
3. Build the release version:
   ```bash
   flutter build ipa
   ```

### Android
To build the `.apk` or App Bundle:
1. Build an APK:
   ```bash
   flutter build apk --release
   ```
2. The output will be located at `build/app/outputs/flutter-apk/app-release.apk`.

## Assets
This project uses the **SevenSegment** font family located in `assets/fonts/`.

## License
This project is licensed under the terms found in the `LICENSE` file.
