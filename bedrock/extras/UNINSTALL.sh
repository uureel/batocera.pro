#!/bin/bash

cd /userdata/system/

rm -rf /userdata/system/pro/bedrock 2>/dev/null 
rm /usr/share/bedrock.desktop 2>/dev/null 

curl http://127.0.0.1:1234/reloadgames 
