#!/bin/bash

# Usage: bash assets/install_icons.sh [ios|android]
# No args = both ios AND android.

PLATFORM=$1
ASSETS_DIR="assets/images"
SRC_OPAQUE="$ASSETS_DIR/app_icon_1024.png"
SRC_TRANSPARENT="$ASSETS_DIR/app_icon_1024_transparent.png"

# --- iOS Function ---
install_ios() {
    echo "Installing iOS icons..."
    IOS_DIR="ios/Runner/Assets.xcassets/AppIcon.appiconset"
    mkdir -p "$IOS_DIR"

    # Generate the specific sizes required for iPhone and iPad
    # Format: sips -z height width source --out destination
    sips -z 40 40   "$SRC_OPAQUE" --out "$IOS_DIR/Icon-40.png" > /dev/null
    sips -z 58 58   "$SRC_OPAQUE" --out "$IOS_DIR/Icon-58.png" > /dev/null
    sips -z 60 60   "$SRC_OPAQUE" --out "$IOS_DIR/Icon-60.png" > /dev/null
    sips -z 76 76   "$SRC_OPAQUE" --out "$IOS_DIR/Icon-76.png" > /dev/null
    sips -z 80 80   "$SRC_OPAQUE" --out "$IOS_DIR/Icon-80.png" > /dev/null
    sips -z 87 87   "$SRC_OPAQUE" --out "$IOS_DIR/Icon-87.png" > /dev/null
    sips -z 120 120 "$SRC_OPAQUE" --out "$IOS_DIR/Icon-120.png" > /dev/null
    sips -z 152 152 "$SRC_OPAQUE" --out "$IOS_DIR/Icon-152.png" > /dev/null
    sips -z 167 167 "$SRC_OPAQUE" --out "$IOS_DIR/Icon-167.png" > /dev/null
    sips -z 180 180 "$SRC_OPAQUE" --out "$IOS_DIR/Icon-180.png" > /dev/null
    cp "$SRC_OPAQUE" "$IOS_DIR/Icon-1024.png"

    cat > "$IOS_DIR/Contents.json" << 'JSON'
{
  "images": [
    { "size": "20x20", "idiom": "universal", "platform": "ios", "scale": "2x", "filename": "Icon-40.png" },
    { "size": "20x20", "idiom": "universal", "platform": "ios", "scale": "3x", "filename": "Icon-60.png" },
    { "size": "29x29", "idiom": "universal", "platform": "ios", "scale": "2x", "filename": "Icon-58.png" },
    { "size": "29x29", "idiom": "universal", "platform": "ios", "scale": "3x", "filename": "Icon-87.png" },
    { "size": "40x40", "idiom": "universal", "platform": "ios", "scale": "2x", "filename": "Icon-80.png" },
    { "size": "40x40", "idiom": "universal", "platform": "ios", "scale": "3x", "filename": "Icon-120.png" },
    { "size": "60x60", "idiom": "universal", "platform": "ios", "scale": "2x", "filename": "Icon-120.png" },
    { "size": "60x60", "idiom": "universal", "platform": "ios", "scale": "3x", "filename": "Icon-180.png" },
    { "size": "76x76", "idiom": "universal", "platform": "ios", "scale": "1x", "filename": "Icon-76.png" },
    { "size": "76x76", "idiom": "universal", "platform": "ios", "scale": "2x", "filename": "Icon-152.png" },
    { "size": "83.5x83.5", "idiom": "universal", "platform": "ios", "scale": "2x", "filename": "Icon-167.png" },
    { "size": "1024x1024", "idiom": "ios-marketing", "scale": "1x", "filename": "Icon-1024.png" }
  ],
  "info": { "author": "xcode", "version": 1 }
}
JSON
    echo "iOS icons installed."
}

# --- Android Function ---
install_android() {
    echo "Installing Android icons..."
    ANDROID_RES="android/app/src/main/res"
    # (Your existing sips logic here...)
    mkdir -p "$ANDROID_RES/mipmap-mdpi"
    sips -z 48 48 "$SRC_TRANSPARENT" --out "$ANDROID_RES/mipmap-mdpi/ic_launcher_foreground.png" > /dev/null
    sips -z 48 48 "$SRC_TRANSPARENT" --out "$ANDROID_RES/mipmap-mdpi/ic_launcher.png" > /dev/null
    # ... (Repeat for hdpi, xhdpi, xxhdpi, xxxhdpi as per your original script)
    # [Truncated for brevity, keep your original block here]
    
    echo "Android icons installed."
}

# --- Logic Control ---
if [ "$PLATFORM" == "ios" ]; then
    install_ios
elif [ "$PLATFORM" == "android" ]; then
    install_android
else
    install_ios
    install_android
fi

echo "All done!"