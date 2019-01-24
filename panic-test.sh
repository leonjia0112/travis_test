#!/bin/bash

# Check the unwrap and panic function presenting in src/ directory
# of the repo. Testing suite is excluded. If such a function presents
# return exit 1 for fail, otherwise return exit 0 for sucess.

# getting the banned list from banned file
banned_list=()

banned_file="$1"
while read -r line; do
    banned_list=(${banned_list[@]} "$line")
done < "$banned_file"

# FOR I IN "${banned_list[@]}"; do
#     ECHO "$i"
# DONE

output=""
panic_line=0

for i in src/*; do
    output="${output}src/$i\n"
    for func in "${banned_list[@]}"; do
        tmp_line=$(sed '/Unit Testing/q' $i | grep -e "$func" | awk 'END {print NR}')
        # sed '/Unit Testing/q' $i | grep -e "$func"
        if [ "$tmp_line" -gt 0 ]; then
            tmp_output=$(sed '/Unit Testing/q' $i | grep -n -e "$func")
            output="${output}${tmp_output}\n"
            panic_line=$(($panic_line+$tmp_line))
        else
            echo ""
        fi
    done
done

if [ "$panic_line" -gt 0 ]
then
    echo "exit 1. Please removed all the following panic calls."
    printf "$output"
    exit 1
else
    exit 0
fi
