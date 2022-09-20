#!/bin/bash

rm -rf build
mkdir build
cd backend || exit

echo Build fatJAR file...

./gradlew buildFatJar

echo Move output backend file to build directory...

mv "build/libs/backend.jar" "../build/$1.jar"
