#!/bin/bash

# Check the unwrap and panic function presenting in src/ directory
# of the repo. Testing suite is excluded. If such a function presents
# return exit 1 for fail, otherwise return exit 0 for sucess.

output=""
panic_line=0

for i in src/*; do
    tmp_line=$(sed '/Unit Testing/q' $i | grep -e "unwrap()" -e "panic!(.*)" | awk 'END {print NR}')
    if [ "$tmp_line" -gt 0 ]; then
        tmp_output=$(sed '/Unit Testing/q' $i | grep -n -e "unwrap()" -e "panic!(.*)")
        output="$src/$i${output}\n${tmp_output}\n"
        panic_line=$(($panic_line+$tmp_line))
    else
        echo "All clear !"
    fi
done

if [ "$panic_line" -gt 0 ]
then
    echo "exit 1. Please removed all the following panic calls."
    printf "$output"
    exit 1
else
    exit 0
fi
