#!/usr/bin/v run

import os
import regex

fn text_to_num (s string) string {

    if s.len > 1 {
        return match s {
            'one' { '1' }
            'two' { '2' }
            'three' { '3' }
            'four' { '4' }
            'five' { '5' }
            'six' { '6' }
            'seven' { '7' }
            'eight' { '8' }
            'nine' { '9' }
             else { '0' }
        }
    } else {
        return s
    }
}

mut lines := os.read_lines('./day1.txt') or { panic(err) }
mut re := regex.regex_opt(r'(\d)|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)') or { panic(err) }
mut re_twone := regex.regex_opt(r'twone') or { panic(err) }
mut re_oneight := regex.regex_opt(r'oneight') or { panic(err) }

mut numbers := []u8

for line in lines {
    fixed_line := re_twone.replace_simple(line, '21')
    fixed_line2 := re_oneight.replace_simple(fixed_line, '18')
    nums := re.find_all_str(fixed_line2)
    //println('first  ${nums.len}')
    first := nums[0]
    last := nums[nums.len-1]
    number := (text_to_num(first)+text_to_num(last)).u8()
    println('${line}: first=${first} last=${last} -> number is ${number}')
    numbers << number
}

mut final_num := u32(0)

for num in numbers { final_num += num }


println('Final number is ${final_num}')


