#!/bin/bash

# Part 1: Generate emulator launch scripts
TARGET_DIR="/userdata/roms/emulator"
mkdir -p "$TARGET_DIR"

EMULATOR_COMMANDS=(
    "batocera-config-bigpemu"
    "batocera-config-cemu"
    "batocera-config-citra"
    "batocera-config-dolphin"
    "batocera-config-dolphin-triforce"
    "batocera-config-duckstation"
    "batocera-config-flycast"
    "batocera-config-fpinball"
    "batocera-config-model2emu"
    "batocera-config-pcsx2"
    "batocera-config-play"
    "batocera-config-ppsspp"
    "batocera-config-retroarch"
    "batocera-config-rpcs3"
    "batocera-config-scummvm"
    "batocera-config-vita3k"
    "batocera-config-xenia"
    "batocera-config-xenia-canary"
)

for cmd in "${EMULATOR_COMMANDS[@]}"; do
    emulator_name="${cmd#batocera-config-}"
    script_path="$TARGET_DIR/$emulator_name.sh"
    
    echo "#!/bin/bash" > "$script_path"
    echo "unclutter-remote -s" >> "$script_path"
    echo "DISPLAY=:0.0 $cmd" >> "$script_path"
    
    chmod +x "$script_path"
    
    echo "Generated script for $emulator_name at $script_path"
done

# Part 2: Create or update the es_systems_emulators.cfg file
CONFIG_DIR="$HOME/configs/emulationstation"
CONFIG_FILE="es_systems_emulators.cfg"
mkdir -p "$CONFIG_DIR"

XML_CONTENT='<?xml version="1.0"?>
<systemList>
    <system>
        <fullname>Emulators</fullname>
        <name>Emulators</name>
        <manufacturer>NONE</manufacturer>
        <release>2021</release>
        <hardware>port</hardware>
        <path>/userdata/roms/emulator</path>
        <extension>.sh</extension>
        <command>%ROM%</command>
        <platform>pc</platform>
        <theme>linux</theme>
        <emulators>
            <emulator name="emulators">
                <cores>
                    <core default="true">emulators</core>
                </cores>
            </emulator>
        </emulators>
    </system>
</systemList>'

echo "$XML_CONTENT" > "$CONFIG_DIR/$CONFIG_FILE"

echo "The configuration file has been created/updated at $CONFIG_DIR/$CONFIG_FILE"

