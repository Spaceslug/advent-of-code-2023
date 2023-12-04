#!/usr/bin/v run

import os
import regex
import arrays

struct Point {
	x i64
	y i64
}

struct Box {
    up_left Point
    do_right Point
}

fn box_has_symbol(box Box, symbol_array [][]bool, mut gears map[string][]i64, number i64) bool {
    for i := box.up_left.y; i < box.do_right.y; i+=1 {
        if i < 0 || i >= symbol_array.len { continue }
        //println('Line $i')
        for j := box.up_left.x; j < box.do_right.x; j+=1 {
            if j < 0 || j >= symbol_array[0].len { continue }
            //print(' [$i,$j,${symbol_array[i][j]}] ')
            if symbol_array[i][j] {
                gears['[$j,$i]'] << number
            }
        }
    }
    return false
}

mut lines := os.read_lines('./day3.txt') or { panic(err) }
//mut re := regex.regex_opt(r'(\d)|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)') or { panic(err) }
//mut re_twone := regex.regex_opt(r'twone') or { panic(err) }
//mut re_oneight := regex.regex_opt(r'oneight') or { panic(err) }

mut symol_array := [][]bool{len: lines.len, init: []bool{len: lines[0].len, init: false}}
println('Array: ${symol_array}')

mut total := i64(0)
mut gear_map := map[string][]i64{}

mut re := regex.regex_opt(r'[*]{1}') or { panic(err) }
mut re_num := regex.regex_opt(r'\d+') or { panic(err) }

for i, line in lines {
    mut symbols := []int{}
    symbols = re.find_all(line)
    indexes := arrays.filter_indexed(symbols, fn (idx int, x int) bool { return idx % 2 == 0 } )
    println('Symbols $i ${symbols} ${indexes}')

    for index in indexes {
        symol_array[i][index] = true
        gear_map['[$index,$i]'] = []
    }
}

for line_num, line in lines {
    numbers := re_num.find_all(line)

    mut points := []Box{}
    for i := 0; i < numbers.len; i += 2 {

        number_str := line.substr(numbers[i], numbers[i+1])
        number := number_str.i64()
        points << Box{Point{x: numbers[i]-1, y: line_num-1}, Point{x: numbers[i+1]+1, y: line_num+2}}
        if box_has_symbol(points.last(), symol_array, mut gear_map, number) {
            total += number_str.i64()
            println('Line $line_num Number: ${number_str} has symbol adjacent. Total=$total')
            //if '944' == number_str { return }

        }
    }

    //println('Points: ${points} Line=${line}')

    // 3,4, 14, 15, 24, 25,

}

//println('Array: ${symol_array}')
println('Total is ${total}')

mut new_total := i64(0)

for point,numbers in gear_map {
    println('Gear $point: $numbers')
    if numbers.len == 2 {
        new_total += ( numbers[0] * numbers[1])
        println('New total $new_total from ${numbers[0]} * ${numbers[1]}')
    }
}

println('New Total is ${new_total}')
