#!/bin/bash

# Prevent the Xcode run script phase from running script.sh recursively
export IS_BUILDING_XCFRAMEWORK=1

# Fast simulator development build script
PROJECT_NAME="Home"
BUILD_DIR="build_dev"
OUTPUT_FRAMEWORK_DIR="../Framework/${PROJECT_NAME}.xcframework/ios-arm64_x86_64-simulator"

echo "Building Debug Simulator slice for ${PROJECT_NAME}..."

# Build only the simulator target in Debug mode (much faster than full archive)
xcodebuild build \
  -project "${PROJECT_NAME}.xcodeproj" \
  -scheme "${PROJECT_NAME}" \
  -configuration Debug \
  -sdk iphonesimulator \
  -derivedDataPath "$BUILD_DIR" \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY=""

# Check if build succeeded
if [ $? -eq 0 ]; then
  echo "Build Succeeded. Updating framework in xcframework..."
  
  # Remove old framework in the simulator slice of the xcframework
  rm -rf "${OUTPUT_FRAMEWORK_DIR}/${PROJECT_NAME}.framework"
  
  # Copy the newly compiled framework
  cp -R "${BUILD_DIR}/Build/Products/Debug-iphonesimulator/${PROJECT_NAME}.framework" "${OUTPUT_FRAMEWORK_DIR}/"
  
  echo "Successfully updated Simulator slice in ${PROJECT_NAME}.xcframework!"
else
  echo "Build Failed!"
  exit 1
fi
