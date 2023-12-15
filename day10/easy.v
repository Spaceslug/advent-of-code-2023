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

fn pipe_connections(pos Pos, prev Pos, pipe_map [][]rune) Pos {
    next1, next2 := match pipe_map[pos.row][pos.col] {
        `J` { Pos{row:pos.row-1,col:pos.col}, Pos{row:pos.row,col:pos.col-1}}
        `-` { Pos{row:pos.row,col:pos.col+1}, Pos{row:pos.row,col:pos.col-1}}
        `|` { Pos{row:pos.row-1,col:pos.col}, Pos{row:pos.row+1,col:pos.col}}
        `L` { Pos{row:pos.row-1,col:pos.col}, Pos{row:pos.row,col:pos.col+1}}
        `7` { Pos{row:pos.row+1,col:pos.col}, Pos{row:pos.row,col:pos.col-1}}
        `F` { Pos{row:pos.row+1,col:pos.col}, Pos{row:pos.row,col:pos.col+1}}
        else { panic('waaa') }
    }
    if next1 == prev {
        return next2
    } else if next2 == prev {
        return next1
    } else {
        panic('yyyeyey')
    }

}

struct Pos {
    row int
    col int
}

fn (a Pos) == (b Pos) bool {
    return a.row == b.row && a.col == b.col
}

fn (x Pos) str() string {
    return '{row:${x.row},col:${x.col}}'
}

mut lines := os.read_lines('./input.txt') or { panic(err) }

mut pipe_map := [][]rune{}

mut start_row := 0
mut start_col := 0

for line in lines {
    pipe_map << line.runes()
}

for i,row in pipe_map {
    for j,pipe in row {
        if pipe == `S` {
            start_row = i
            start_col = j
        }
    }
}

// hard code first pipe is bellow

println('$pipe_map')

first_pipe := Pos{row:start_row+1,col:start_col}

mut pipe_loop := []Pos{}
pipe_loop << Pos{row: start_row, col: start_col}

pipe_loop << first_pipe

for {
    next := pipe_connections(pipe_loop.last(), pipe_loop[pipe_loop.len - 2], pipe_map)
    if pipe_map[next.row][next.col] == `S` {
        println('Found en of line!!')
        break
    }
    pipe_loop << next
    println('${pipe_map[pipe_loop.last().row][pipe_loop.last().col]} ${pipe_loop.last()}')
}


println('Loop length is ${pipe_loop.len} and steps to middway is ${(pipe_loop.len)/2} ')

