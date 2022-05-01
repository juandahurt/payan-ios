#!/bin/bash

set -eo pipefail

xcodebuild -archivePath $PWD/build/Payan.xcarchive \
            -exportOptionsPlist Payan/exportOptions.plist \
            -exportPath $PWD/build \
            -allowProvisioningUpdates \
            -exportArchive | xcpretty