#!/bin/bash

# Boom Build Script
# Builds the app and creates distributable files in the dist folder

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Boom Build Script ===${NC}"

# Configuration
PROJECT_NAME="boom"
SCHEME="boom"
BUILD_DIR="build"
DIST_DIR="dist"
APP_NAME="Boom.app"

# Get version from Xcode project
VERSION=$(xcodebuild -project "${PROJECT_NAME}.xcodeproj" -scheme "${SCHEME}" -showBuildSettings 2>/dev/null | grep "MARKETING_VERSION" | head -1 | sed 's/.*= //')
BUILD_NUMBER=$(xcodebuild -project "${PROJECT_NAME}.xcodeproj" -scheme "${SCHEME}" -showBuildSettings 2>/dev/null | grep "CURRENT_PROJECT_VERSION" | head -1 | sed 's/.*= //')

# Fallback if version extraction fails
VERSION=${VERSION:-"1.0.0"}
BUILD_NUMBER=${BUILD_NUMBER:-"1"}

echo -e "${GREEN}Building version: ${VERSION} (${BUILD_NUMBER})${NC}"

# Clean previous builds
echo -e "${YELLOW}Cleaning previous builds...${NC}"
rm -rf "${BUILD_DIR}"
rm -rf "${DIST_DIR}"
mkdir -p "${DIST_DIR}"

# Build the app
echo -e "${YELLOW}Building ${PROJECT_NAME}...${NC}"
xcodebuild \
    -project "${PROJECT_NAME}.xcodeproj" \
    -scheme "${SCHEME}" \
    -configuration Release \
    -derivedDataPath "${BUILD_DIR}" \
    -arch arm64 \
    -arch x86_64 \
    CODE_SIGN_IDENTITY="-" \
    CODE_SIGNING_REQUIRED=NO \
    CODE_SIGNING_ALLOWED=NO \
    ONLY_ACTIVE_ARCH=NO \
    clean build \
    2>&1 | while read line; do
        if [[ "$line" == *"error:"* ]]; then
            echo -e "${RED}${line}${NC}"
        elif [[ "$line" == *"warning:"* ]]; then
            echo -e "${YELLOW}${line}${NC}"
        elif [[ "$line" == *"BUILD SUCCEEDED"* ]]; then
            echo -e "${GREEN}${line}${NC}"
        fi
    done

# Check if build succeeded
APP_PATH="${BUILD_DIR}/Build/Products/Release/${APP_NAME}"
if [ ! -d "${APP_PATH}" ]; then
    echo -e "${RED}Build failed: ${APP_NAME} not found${NC}"
    exit 1
fi

echo -e "${GREEN}Build succeeded!${NC}"

# Copy app to dist
echo -e "${YELLOW}Copying app to dist...${NC}"
cp -R "${APP_PATH}" "${DIST_DIR}/"

# Create ZIP archive
echo -e "${YELLOW}Creating ZIP archive...${NC}"
ZIP_NAME="Boom-${VERSION}.zip"
cd "${DIST_DIR}"
zip -r -y "${ZIP_NAME}" "${APP_NAME}"
cd ..

# Create DMG (optional, if create-dmg is available)
if command -v create-dmg &> /dev/null; then
    echo -e "${YELLOW}Creating DMG...${NC}"
    DMG_NAME="Boom-${VERSION}.dmg"
    create-dmg \
        --volname "Boom" \
        --window-pos 200 120 \
        --window-size 600 400 \
        --icon-size 100 \
        --icon "${APP_NAME}" 150 185 \
        --app-drop-link 450 185 \
        "${DIST_DIR}/${DMG_NAME}" \
        "${DIST_DIR}/${APP_NAME}" \
        2>/dev/null || echo -e "${YELLOW}DMG creation skipped (create-dmg failed)${NC}"
else
    echo -e "${YELLOW}Skipping DMG creation (install create-dmg for DMG support)${NC}"
fi

# Clean up build directory
echo -e "${YELLOW}Cleaning up...${NC}"
rm -rf "${BUILD_DIR}"

# Summary
echo ""
echo -e "${GREEN}=== Build Complete ===${NC}"
echo -e "Version: ${VERSION} (${BUILD_NUMBER})"
echo -e "Output directory: ${DIST_DIR}/"
echo ""
echo "Contents:"
ls -lh "${DIST_DIR}/"
echo ""
echo -e "${GREEN}Ready for distribution!${NC}"
