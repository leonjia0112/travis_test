#!/bin/bash

# Check the unwrap and panic function presenting in src/ directory
# of the repo. Testing suite is excluded. If such a function presents
# return exit 1 for fail, otherwise return exit 0 for sucess.

output=""
panic_line=0

for i in src/*; do
    tmp_output=$(sed '/Unit Testing/q' $i | grep -n -e unwrap -e panic)
    output="${output}\n${tmp_output}"
    line=$(echo $tmp_output | awk 'END {print NR}')
    panic_line=$(($panic_line+$line))
done

printf "This output has %d lines.\n" "$panic_line"
# printf "$output"

if [ "$panic_line" -gt 0 ]
then
    printf "$output"
    exit 1
else
    exit 0
fi
