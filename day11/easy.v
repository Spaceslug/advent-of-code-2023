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

struct Pos {
    row int
    col int
}

fn (a Pos) == (b Pos) bool {
    return a.row == b.row && a.col == b.col
}

fn (a Pos) distance (b Pos) int {
    x := if a.col > b.col { a.col - b.col } else { b.col - a.col }
    y := if a.row > b.row { a.row - b.row } else { b.row - a.row }
    return x + y
}

fn (x Pos) str() string {
    return '{row:${x.row},col:${x.col}}'
}

mut lines := os.read_lines('./input.txt') or { panic(err) }

mut stars := []Pos{}
mut total := 0

for i := 0; i < lines.len; i+=1 {
    if lines[i].runes().all(it==`.`) {
        lines.insert(i, lines[i])
        i+=1
        println('Inserted line at $i')
    }
}

for i := 0; i < lines[0].len; i+=1 {

    mut not_empty := false
    for line in lines {
        if line[i] != `.` {
            not_empty = true
        }
    }
    if !not_empty {
        for j, mut line in lines {
            //println('len ${line.len}')
            line = line[..i] + '.' + line[i..]
            //println('len2 ${lines[j].len}')
        }
        println('Inserted row at $i')
        i+=1
    }

}

println('rows ${lines.len} columns ${lines[0].len}')

for i,line in lines {
    for j,run in line {
        if run == `#` {
            stars << Pos{row:i,col:j}
        }
    }
}

for stars.len > 0 {
    star := stars.pop()
    for t_star in stars {
        total += star.distance(t_star)
    }
    println('After $star total is $total')
}


println('Total distance $total')
