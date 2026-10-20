# Project Test
### FLUTTER VERSION ###
* Version: 3.41.6
### Setup

```console
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
rm -rf ios/Pods ios/Podfile.lock
flutter clean
flutter pub get
pod install
```
