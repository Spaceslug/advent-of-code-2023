#!/usr/bin/v run

import os
import regex


mut lines := os.read_lines('./day1.txt') or { panic(err) }
mut re := regex.regex_opt(r'\d') or { panic(err) }

mut numbers := []u8

for line in lines {
    nums := re.find_all_str(line)
    first := nums[0]
    last := nums[nums.len-1]
    number := (first+last).u8()
    println('${line} number is ${number}')
    numbers << number
}

mut final_num := u32(0)

for num in numbers { final_num += num }


println('Final number is ${final_num}')


