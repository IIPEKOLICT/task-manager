#!/bin/bash

rm -rf build
mkdir build
cd frontend || exit

echo Install dependencies...

flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs

echo Test code...

flutter test

echo Build APK and AAB files...

flutter build apk --dart-define=BACKEND_URL="$BACKEND_URL"
flutter build appbundle --dart-define=BACKEND_URL="$BACKEND_URL"

echo Move output client files to build directory...

mv "build/app/outputs/flutter-apk/app-release.apk" "../build/$1.apk"
mv "build/app/outputs/bundle/release/app-release.aab" "../build/$1.aab"
