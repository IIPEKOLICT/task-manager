#!/bin/bash

rm -rf build
mkdir build
cd backend || exit

echo Test backend...

./gradlew test

echo Build backend fat jar...

./gradlew buildFatJar

echo Move output fat jar to build directory...

mv build/libs/backend.jar ../build/backend.jar
