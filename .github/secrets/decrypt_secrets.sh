#!/bin/sh
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
set -eo pipefail

gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/payan_profile.mobileprovision ./.github/secrets/payan_profile.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/payan_certificate.p12 ./.github/secrets/payan_certificate.p12.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

cp ./.github/secrets/payan_profile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/payan_profile.mobileprovision


security create-keychain -p "" build.keychain
security import ./.github/secrets/payan_certificate.p12 -t agg -k ~/Library/Keychains/build.keychain -P "" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain