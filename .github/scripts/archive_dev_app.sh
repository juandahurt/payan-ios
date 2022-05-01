#!/bin/bash

set -eo pipefail

xcodebuild -project Payan.xcodeproj \
            -scheme Payan\ (dev) \
            -sdk iphoneos \
            -configuration AppStoreDistribution \
            -archivePath $PWD/build/Payan.xcarchive \
            clean archive | xcpretty