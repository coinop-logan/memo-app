# Memo App Build Instructions

## Local Build Setup (Completed)

The local Android build environment is fully configured on the desktop machine.

### Prerequisites Installed
- Rust with Android targets: `aarch64-linux-android`, `armv7-linux-androideabi`, `x86_64-linux-android`, `i686-linux-android`
- Dioxus CLI v0.7.1: `~/.cargo/bin/dx`
- Android SDK at: `/home/oglog/android-sdk`
- Android NDK 26.1.10909125 at: `/home/oglog/android-sdk/ndk/26.1.10909125`
- Java 17 (OpenJDK)

### Environment Variables
Required for builds:
```bash
export ANDROID_HOME=/home/oglog/android-sdk
export ANDROID_NDK_ROOT=/home/oglog/android-sdk/ndk/26.1.10909125
```

These are already added to `~/.bashrc`.

## Building APK for Galaxy A14 5G (ARM64)

### Quick Build Command
```bash
cd /home/oglog/projects/memo-app && \
export ANDROID_HOME=/home/oglog/android-sdk && \
export ANDROID_NDK_ROOT=/home/oglog/android-sdk/ndk/26.1.10909125 && \
dx build --platform android --target aarch64-linux-android --release
```

### Output Location
The APK will be at:
```
/home/oglog/projects/memo-app/target/dx/memo-app/release/android/app/app/build/outputs/apk/debug/app-debug.apk
```

### Build Times
- First build: ~5-10 minutes (compiling 356 packages)
- Incremental builds: ~30 seconds to 2 minutes (depending on changes)

## Creating GitHub Releases

After building, create a release:
```bash
cd /home/oglog/projects/memo-app
cp target/dx/memo-app/release/android/app/app/build/outputs/apk/debug/app-debug.apk memo-app-build-X.apk

GH_TOKEN=<token> gh release create build-X \
  memo-app-build-X.apk \
  --title "Build #X" \
  --notes "Description of changes" \
  --repo coinop-logan/memo-app
```

GitHub token is in the git remote URL configuration.

## Important Notes

### Architecture Targeting
**CRITICAL**: The `architectures` field in `Dioxus.toml` does NOT work as expected with `dx build`.

To target specific architectures, you MUST use the `--target` flag:
- ARM64 (Galaxy A14 5G): `--target aarch64-linux-android`
- ARMv7: `--target armv7-linux-androideabi`
- x86_64 (emulator): `--target x86_64-linux-android`
- x86 (emulator): `--target i686-linux-android`

### Clean Builds
If you need a completely clean build:
```bash
rm -rf target/dx target/aarch64-linux-android
```

### Verifying APK Architecture
To check which architecture an APK contains:
```bash
unzip -l <apk-file> | grep "lib/"
```

Should show something like:
```
lib/arm64-v8a/libdioxusmain.so
```

## Current Status

### Working
- ✅ Local build environment fully set up
- ✅ Building ARM64 APKs for Galaxy A14 5G
- ✅ GitHub release creation workflow
- ✅ Development loop validated (code → build → release → download → test)

### Not Working / Not Tested
- ❌ GitHub Actions builds (workflow exists but needs `--target` flag added)
- ❌ Multi-architecture universal APKs
- ❌ Release builds (currently using debug builds)

## GitHub Actions Fix (TODO)

The GitHub Actions workflow at `.github/workflows/build-android.yml` needs to be updated.

Change line 43 from:
```yaml
run: dx build --platform android --release
```

To:
```yaml
run: dx build --platform android --target aarch64-linux-android --release
```

This will make CI builds compatible with the target device.
