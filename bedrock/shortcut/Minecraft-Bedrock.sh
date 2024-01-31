#!/bin/bash
unclutter-remote -s
LD_LIBRARY_PATH="/userdata/system/pro/.dep:${LD_LIBRARY_PATH}" DISPLAY=:0.0 /userdata/system/pro/bedrock/bedrock.AppImage

