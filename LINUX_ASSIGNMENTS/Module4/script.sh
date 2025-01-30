#!/bin/bash

touch output.txt


echo "" > output.txt 

head -n 3000 "$1" | while read -r line; do


        echo "$line" | grep -E '"(frame\.time|wlan\.fc\.type|wlan\.fc\.subtype)":' | sed -E 's/"(frame\.time|wlan\.fc\.type|wlan\.fc\.subtype)": "(.+)/\1 \2/' | while read -r param value; do


                echo "\"$param\": \"$value" >> output.txt

        done

done
