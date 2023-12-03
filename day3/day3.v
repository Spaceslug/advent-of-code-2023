#!/usr/bin/v run

import os
import regex

struct Point {
	x int
	y int
}

struct Box {
    up_left Point
    do_right Point
}

fn box_has_symbol(box Box, symbol_array [][]bool)  {
    for i := box.up_left.y; i < box.do_right.y; i+=1 {
        if i < 0 || i >= symbol_array.len { continue }
        for j := box.up_left.x; j < box.do_right.x; j+=1 {
            if j < 0 || j >= symbol_array[0].len { continue }
            if
        }
    }
    return false
}

mut lines := os.read_lines('./day3test.txt') or { panic(err) }
//mut re := regex.regex_opt(r'(\d)|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)') or { panic(err) }
//mut re_twone := regex.regex_opt(r'twone') or { panic(err) }
//mut re_oneight := regex.regex_opt(r'oneight') or { panic(err) }

mut symol_array := [][]bool{len: lines.len, init: []bool{len: lines[0].len, init: false}}
println('Array: ${symol_array}')

mut total := 0

mut re := regex.regex_opt(r'[^\.\n\d]{1}') or { panic(err) }
mut re_num := regex.regex_opt(r'\d+') or { panic(err) }

for i, line in lines {
    mut symbols := []int
    symbols = re.find_all(line)
    indexes := symbols.filter(it % 2 == 1)
    println('Symbols $i ${symbols} ${indexes}')

    for index in indexes {
        symol_array[i][index] = true
    }
}

for line_num, line in lines {
    numbers := re_num.find_all(line)

    mut points := []Box
    for i := 0; i < numbers.len; i += 2 {
        points << Box{Point{x: numbers[i]-1, y: line_num-1}, Point{x: numbers[i+1], y: line_num+1}}
    }
    println('Points: ${points} Line=${line}')



}

println('Array: ${symol_array}')
println('Total is ${total}')

