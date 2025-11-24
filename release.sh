#!/bin/bash
# Create a GitHub release with the built APK

set -e

if [ $# -lt 2 ]; then
    echo "Usage: ./release.sh <build-number> <description>"
    echo "Example: ./release.sh 3 \"Added text input feature\""
    exit 1
fi

BUILD_NUM=$1
DESCRIPTION=$2

APK_PATH="target/dx/memo-app/release/android/app/app/build/outputs/apk/debug/app-debug.apk"

if [ ! -f "$APK_PATH" ]; then
    echo "Error: APK not found at $APK_PATH"
    echo "Run ./build-arm64.sh first"
    exit 1
fi

# Copy APK with descriptive name
RELEASE_APK="memo-app-build-${BUILD_NUM}.apk"
cp "$APK_PATH" "$RELEASE_APK"

echo "Creating GitHub release: build-${BUILD_NUM}"

# Get GitHub token from git remote
GIT_REMOTE=$(git remote get-url origin)
if [[ $GIT_REMOTE =~ x-access-token:([^@]+)@ ]]; then
    GITHUB_TOKEN="${BASH_REMATCH[1]}"
else
    echo "Error: Could not extract GitHub token from git remote"
    exit 1
fi

# Create release
GH_TOKEN="$GITHUB_TOKEN" gh release create "build-${BUILD_NUM}" \
    "$RELEASE_APK" \
    --title "Build #${BUILD_NUM}" \
    --notes "${DESCRIPTION}

Built locally for ARM64 (aarch64) - compatible with Galaxy A14 5G." \
    --repo coinop-logan/memo-app

echo ""
echo "Release created successfully!"
echo "URL: https://github.com/coinop-logan/memo-app/releases/tag/build-${BUILD_NUM}"

# Clean up
rm "$RELEASE_APK"
