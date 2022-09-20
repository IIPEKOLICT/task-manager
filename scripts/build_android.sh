#!/bin/bash

rm -rf build
mkdir build
cd frontend/android || exit

echo Test client code...

./gradlew test

echo Build APK and AAB files...

./gradlew assembleRelease
./gradlew bundleRelease

echo Move output client files to build directory...

mv "app/build/outputs/apk/release/app-release.apk" "../../build/$1.apk"
mv "app/build/outputs/bundle/release/app-release.aab" "../../build/$1.aab"
