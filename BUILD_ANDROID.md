# Android build notes

The first target is an Android landscape build.

## Required tools
- Haxe and Haxelib
- Lime, OpenFL, and HaxeFlixel
- Android SDK and build tools
- A compatible JDK and Android NDK where required by the selected Lime target

## Haxelib setup
```sh
haxelib install lime
haxelib install openfl
haxelib install flixel
haxelib run lime setup
haxelib run lime setup android
```

## Build
First validate the project on a desktop target:
```sh
haxelib run lime test neko
```

Then, after the Android SDK/JDK configuration is installed:
```sh
haxelib run lime build android
```

Android toolchain versions will be pinned in CI only after a clean build verifies compatibility. No APK pipeline is considered working until an actual build succeeds.
