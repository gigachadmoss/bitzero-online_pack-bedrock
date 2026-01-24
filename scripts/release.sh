#!/usr/bin/env bash

set -e

RELEASE_PREFIX="bitzero-online_pack-bedrock"
TARGET_PATH_BASE="./target/pack/"
COMBAT_WEAPONRY_PLUS=1
COMBAT_WEAPONRY_PLUS_RP_URL="https://www.dropbox.com/scl/fi/dhgubahgx3z0phg4wnbw3/cwp-texture-pack-1.5.7.zip?rlkey=cxtqp9575bk28qr90vyxb2tdv&dl=1"

TARGET_PATH="${TARGET_PATH_BASE}/${RELEASE_PREFIX}.mcpack"

mkdir -p target/
rm -rf target/workingpack/
rm -rf target/remotes/
mkdir -p target/workingpack/
mkdir -p target/remotes/
mkdir -p target/pack/

# Process our resources
cp -a font target/workingpack/

# Copy metadata
cp manifest.json target/workingpack/
cp pack_icon.png target/workingpack/

# Combat Weaponry Plus Injection
if [[ "$COMBAT_WEAPONRY_PLUS" == "1" ]]; then
    echo "Injecting Combat Weaponry Plus resources"

    curl -Lo target/remotes/combatweaponryplus.zip "$COMBAT_WEAPONRY_PLUS_RP_URL"

    mkdir -p target/remotes/combatweaponryplus
    unzip target/remotes/combatweaponryplus.zip -d target/remotes/combatweaponryplus

    cp -a cwp/animations target/workingpack/
    cp -a cwp/attachables target/workingpack/
    cp -a cwp/models target/workingpack/
    cp -a cwp/textures target/workingpack/

    cp -a target/remotes/combatweaponryplus/assets/minecraft/textures/item/* target/workingpack/textures/minecraft/item/

    echo "Combat Weaponry Plus is UNLICENSED! The assets used may not be safe to distribute at mass."
    echo "Combat Weaponry Plus injection finished"
else
    echo "Combat Weaponry Plus injection skipped"
fi

rm -f "$TARGET_PATH"
cd target/workingpack/
zip -r "../../$TARGET_PATH" *
cd ../../

echo "Done!"
