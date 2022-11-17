#!/bin/bash

rm -rf build
mkdir build
cd frontend/android || exit

echo Install dependencies...

flutter pub get

echo Test code...

flutter test

echo Build APK and AAB files...

flutter build apk
flutter build appbundle

echo Move output client files to build directory...

mv "../build/app/outputs/apk/release/app-release.apk" "../../build/$1.apk"
mv "../build/app/outputs/bundle/release/app-release.aab" "../../build/$1.aab"
