# Memo App

A mobile self-memo app built with Rust and Dioxus.

## Features (Planned)
- Text memos
- Voice memos
- Quick capture
- Notifications

## Building

### Quick Start
```bash
./build-arm64.sh              # Build ARM64 APK
./release.sh 3 "Description"  # Create GitHub release
```

### Manual Build
```bash
export ANDROID_HOME=/home/oglog/android-sdk
export ANDROID_NDK_ROOT=/home/oglog/android-sdk/ndk/26.1.10909125
dx build --platform android --target aarch64-linux-android --release
```

APK output: `target/dx/memo-app/release/android/app/app/build/outputs/apk/debug/app-debug.apk`

### Download
Download the latest APK from the [Releases](../../releases) page.

### Documentation
See `notes/build-instructions.md` for complete build setup and troubleshooting.
