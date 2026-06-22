#!/bin/bash

# Guard against infinite recursion when called from Xcode build phase
if [ "$IS_BUILDING_XCFRAMEWORK" = "1" ]; then
  echo "Preventing recursive build loop, exiting script.sh phase."
  exit 0
fi

export IS_BUILDING_XCFRAMEWORK=1

PROJECT_NAME=$1
BUILD_DIR="build"
OUTPUT_DIR="../Framework"

# Clean previous artifacts
rm -rf "$BUILD_DIR"
rm -rf "$OUTPUT_DIR/$PROJECT_NAME.xcframework"

xcodebuild archive \
  -scheme "$PROJECT_NAME" \
  -configuration Release \
  -destination "generic/platform=iOS" \
  -archivePath "$BUILD_DIR/${PROJECT_NAME}-iOS.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY=""

xcodebuild archive \
  -scheme "$PROJECT_NAME" \
  -configuration Release \
  -destination "generic/platform=iOS Simulator" \
  -archivePath "$BUILD_DIR/${PROJECT_NAME}-Simulator.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY=""

xcodebuild -create-xcframework \
  -framework "$BUILD_DIR/${PROJECT_NAME}-iOS.xcarchive/Products/Library/Frameworks/${PROJECT_NAME}.framework" \
  -framework "$BUILD_DIR/${PROJECT_NAME}-Simulator.xcarchive/Products/Library/Frameworks/${PROJECT_NAME}.framework" \
  -output "$OUTPUT_DIR/$PROJECT_NAME.xcframework"

rm -rf "$BUILD_DIR"
