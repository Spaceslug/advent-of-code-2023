#!/usr/bin/v run

import os
//import arrays

pub fn foldr[T, R](array []T, init R, fold_op fn (acc R, elem T) R) R {
	        unsafe {
	mut value := init
	for e in array {
		value = fold_op(value, e)
	}
	return value
    }

	}

mut lines := os.read_lines('./input.txt') or { panic(err) }

mut pipe_map := [][]rune{}

mut start_row := 0
mut start_col := 0

for line in lines {
    pipe_map << line.runes()
}

for i,row in pipe_map {
    for j,pipe in pipe_map {
        if pipe == `S` {
            start_row := i
            start_col := j
        }
    }
}

// hard code first pipe is bellow

println('$pipe_map')





//println('Total is ${total}')

