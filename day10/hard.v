#!/usr/bin/v run

import os
import arrays
import datatypes

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

fn flood(pos Pos, pipe_loop []Pos, mut set datatypes.Set[string]) {
    if !pipe_loop.contains(pos) && !set.exists(pos.str()) && pos.row >= 0 && pos.row >= 0 && pos.col >= 0 && pos.row < 140 && pos.col < 140 {
        //println('grow $pos')
        set.add_all([pos.str()])
        flood(Pos{row:pos.row+1,col:pos.col+1}, pipe_loop, mut set)
        flood(Pos{row:pos.row+1,col:pos.col-1}, pipe_loop, mut set)
        flood(Pos{row:pos.row-1,col:pos.col+1}, pipe_loop, mut set)
        flood(Pos{row:pos.row-1,col:pos.col-1}, pipe_loop, mut set)
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

mut l_turns := 0
mut r_turns := 0

first_pipe := Pos{row:start_row+1,col:start_col}

mut pipe_loop := []Pos{}
mut pipe_seg := []rune{}
pipe_loop << Pos{row: start_row, col: start_col}
pipe_seg << `S`

pipe_loop << first_pipe
pipe_seg << pipe_map[first_pipe.row][first_pipe.col]


for {
    next := pipe_connections(pipe_loop.last(), pipe_loop[pipe_loop.len - 2], pipe_map)
    if pipe_map[next.row][next.col] == `S` {
        println('Found en of line!!')
        break
    }
    aaa := match pipe_map[pipe_loop.last().row][pipe_loop.last().col] {
        `J` { if Pos{row:pipe_loop.last().row,col:pipe_loop.last().col-1} == next { 'right' } else { 'left' }  }
        `L` { if Pos{row:pipe_loop.last().row,col:pipe_loop.last().col+1} == next { 'left' } else { 'right' }  }
        `7` { if Pos{row:pipe_loop.last().row,col:pipe_loop.last().col-1} == next { 'left' } else { 'right' }  }
        `F` { if Pos{row:pipe_loop.last().row,col:pipe_loop.last().col+1} == next { 'right' } else { 'left' }  }
        else { '' }
    }
    println('${pipe_map[pipe_loop.last().row][pipe_loop.last().col]} ${pipe_loop.last()} $aaa')
    if aaa == 'left' { l_turns += 1 } else if aaa == 'right' { r_turns += 1 }
    pipe_loop << next
    pipe_seg << pipe_map[next.row][next.col]
    //if pipe_loop.len == 100 { break}
}

println('left $l_turns rigjt $r_turns  loop is left loop')

mut set := datatypes.Set[string]{}
mut dir := 'right'

left_rotate := {'down':'right','right':'up', 'up':'left','left':'down'}
right_rotate := {'down':'left','left':'up', 'up':'right','right':'down'}


for i,seg in pipe_loop {
    if pipe_map[seg.row][seg.col] == `S` { continue }

    pos_to_flood := match dir {
        'right' { Pos{row:seg.row,col:seg.col+1} }
        'up'    { Pos{row:seg.row-1,col:seg.col} }
        'left'  { Pos{row:seg.row,col:seg.col-1} }
        'down'  { Pos{row:seg.row+1,col:seg.col} }
        else { panic('fgesgshsfewfad') }
    }
    flood(pos_to_flood,pipe_loop, mut set)
    println('$i ')

    next := pipe_connections(seg, pipe_loop[i-1], pipe_map)
    rotate := match pipe_map[seg.row][seg.col] {
        `J` { if Pos{row:seg.row,col:seg.col-1} == next { 'right' } else { 'left' }  }
        `L` { if Pos{row:seg.row,col:seg.col+1} == next { 'left' } else { 'right' }  }
        `7` { if Pos{row:seg.row,col:seg.col-1} == next { 'left' } else { 'right' }  }
        `F` { if Pos{row:seg.row,col:seg.col+1} == next { 'right' } else { 'left' }  }
        else { '' }
    }
    if rotate == 'left' { dir = left_rotate[dir]} else if rotate == 'right' { dir = right_rotate[dir] }

}


println('Loop length is ${pipe_loop.len} and steps to middway is ${(pipe_loop.len)/2} ')

mop := arrays.map_of_counts(pipe_seg)
println('$mop')


println('SET $set')
println('SET count ${set.size()}')
