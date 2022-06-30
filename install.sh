#!/bin/bash

# Use patch
echo "Patching..."
patch -p1 < ./hevc-vaapi.diff

# Configure git submodules
echo "Configuring git..."
git config submodule.plugins/obs-outputs/ftl-sdk.url https://github.com/Mixer/ftl-sdk.git
git config submodule.plugins/obs-browser.url https://github.com/obsproject/obs-browser.git
git config submodule.plugins/obs-vst.url https://github.com/obsproject/obs-vst.git
git submodule update

# Create build files
echo "Creating build files..."
cmake -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DBUILD_BROWSER=ON \
    -DCEF_ROOT_DIR="/opt/cef" \
    -B build

# Build project
echo "Building..."
cmake --build build

# Install project
echo "Installing..."
sudo cmake --install build
