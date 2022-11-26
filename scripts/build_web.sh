#!/bin/bash

rm -rf build
mkdir build
cd frontend || exit

echo Install dependencies...

flutter pub get
flutter packages pub run build_runner build

echo Test code...

flutter test

echo Build web version...

flutter build web --release --base-href "/$1/" --dart-define=BACKEND_URL="$BACKEND_URL"

echo Move output web files to build directory...

cp -R build/web/* ../build
