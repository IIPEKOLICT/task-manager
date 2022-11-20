#!/bin/bash

rm -rf build
mkdir build
cd frontend || exit

echo Install dependencies...

flutter pub get

echo Test code...

flutter test

echo Build web version...

flutter build web --release --base-href "/$1/"

echo Move output web files to build directory...

cp -R build/web/* ../build
