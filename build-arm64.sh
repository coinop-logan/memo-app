#!/bin/bash
# Build script for memo-app targeting ARM64 (Galaxy A14 5G)

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Building Memo App for ARM64...${NC}"

# Set Android environment
export ANDROID_HOME=/home/oglog/android-sdk
export ANDROID_NDK_ROOT=/home/oglog/android-sdk/ndk/26.1.10909125

# Build
cd /home/oglog/projects/memo-app
dx build --platform android --target aarch64-linux-android --release

# Show output location
APK_PATH="target/dx/memo-app/release/android/app/app/build/outputs/apk/debug/app-debug.apk"
echo -e "${GREEN}Build complete!${NC}"
echo "APK location: $APK_PATH"
echo "APK size: $(du -h "$APK_PATH" | cut -f1)"

# Verify architecture
echo ""
echo "Architecture verification:"
unzip -l "$APK_PATH" | grep "lib/" | head -1

echo ""
echo -e "${BLUE}To create a GitHub release, run:${NC}"
echo "./release.sh <build-number> \"<description>\""
