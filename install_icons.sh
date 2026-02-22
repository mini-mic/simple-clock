#!/bin/bash

# Run from project root
# Usage: bash assets/install_icons.sh

ASSETS_DIR="assets/images"
SRC_OPAQUE="$ASSETS_DIR/app_icon_1024.png"
SRC_TRANSPARENT="$ASSETS_DIR/app_icon_1024_transparent.png"

echo "Installing iOS icon..."

IOS_DIR="ios/Runner/Assets.xcassets/AppIcon.appiconset"
mkdir -p "$IOS_DIR"
cp "$SRC_OPAQUE" "$IOS_DIR/Icon-1024.png"

cat > "$IOS_DIR/Contents.json" << 'JSON'
{
  "images": [
    {
      "filename": "Icon-1024.png",
      "idiom": "universal",
      "platform": "ios",
      "size": "1024x1024"
    }
  ],
  "info": {
    "author": "xcode",
    "version": 1
  }
}
JSON

echo "iOS icon installed."

echo "Installing Android icons..."

ANDROID_RES="android/app/src/main/res"

mkdir -p "$ANDROID_RES/mipmap-mdpi"
sips -z 48 48 "$SRC_TRANSPARENT" --out "$ANDROID_RES/mipmap-mdpi/ic_launcher_foreground.png" > /dev/null
sips -z 48 48 "$SRC_TRANSPARENT" --out "$ANDROID_RES/mipmap-mdpi/ic_launcher.png" > /dev/null

mkdir -p "$ANDROID_RES/mipmap-hdpi"
sips -z 72 72 "$SRC_TRANSPARENT" --out "$ANDROID_RES/mipmap-hdpi/ic_launcher_foreground.png" > /dev/null
sips -z 72 72 "$SRC_TRANSPARENT" --out "$ANDROID_RES/mipmap-hdpi/ic_launcher.png" > /dev/null

mkdir -p "$ANDROID_RES/mipmap-xhdpi"
sips -z 96 96 "$SRC_TRANSPARENT" --out "$ANDROID_RES/mipmap-xhdpi/ic_launcher_foreground.png" > /dev/null
sips -z 96 96 "$SRC_TRANSPARENT" --out "$ANDROID_RES/mipmap-xhdpi/ic_launcher.png" > /dev/null

mkdir -p "$ANDROID_RES/mipmap-xxhdpi"
sips -z 144 144 "$SRC_TRANSPARENT" --out "$ANDROID_RES/mipmap-xxhdpi/ic_launcher_foreground.png" > /dev/null
sips -z 144 144 "$SRC_TRANSPARENT" --out "$ANDROID_RES/mipmap-xxhdpi/ic_launcher.png" > /dev/null

mkdir -p "$ANDROID_RES/mipmap-xxxhdpi"
sips -z 192 192 "$SRC_TRANSPARENT" --out "$ANDROID_RES/mipmap-xxxhdpi/ic_launcher_foreground.png" > /dev/null
sips -z 192 192 "$SRC_TRANSPARENT" --out "$ANDROID_RES/mipmap-xxxhdpi/ic_launcher.png" > /dev/null

echo "Writing Android XML files..."

MIPMAP_ANYDPI="$ANDROID_RES/mipmap-anydpi-v26"
mkdir -p "$MIPMAP_ANYDPI"

cat > "$MIPMAP_ANYDPI/ic_launcher.xml" << 'XML'
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background"/>
    <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>
XML

VALUES_DIR="$ANDROID_RES/values"
mkdir -p "$VALUES_DIR"

cat > "$VALUES_DIR/ic_launcher_background.xml" << 'XML'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ic_launcher_background">#000000</color>
</resources>
XML

echo "Android icons installed."
echo "All done!"
