#!/usr/bin/env -S v run

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
    row i64
    col i64
}

fn (a Pos) == (b Pos) bool {
    return a.row == b.row && a.col == b.col
}

fn (a Pos) distance (b Pos, gap_amount i64, gap_rows []int, gap_cols []int) i64 {
    col_large, col_small := if a.col > b.col { a.col, b.col } else { b.col, a.col }
    extra_cols := gap_cols.filter(it < col_large && it > col_small).len
    extra_col_dist := extra_cols * gap_amount - extra_cols

    row_large, row_small := if a.row > b.row { a.row, b.row } else { b.row, a.row }
    extra_rows := gap_rows.filter(it < row_large && it > row_small).len
    extra_row_dist := extra_rows * gap_amount - extra_rows

    total := col_large - col_small + row_large - row_small + extra_col_dist + extra_row_dist

    //println('from $a to $b')
    //println('extra col $extra_col_dist extra row $extra_row_dist distance $total')
    return total
}

fn (x Pos) str() string {
    return '{row:${x.row},col:${x.col}}'
}

mut lines := read_lines('./input.txt') or { panic(err) }

mut stars := []Pos{}
mut total := i64(0)

gap_amount := i64(1000000)
mut gap_rows := []int
mut gap_cols := []int

for i := 0; i < lines.len; i+=1 {
    if lines[i].runes().all(it==`.`) {
        //lines.insert(i, lines[i])
        //i+=1
        gap_rows << i
        println('Inserted row at $i')
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
        //for j, mut line in lines {
            //println('len ${line.len}')
        //    line = line[..i] + '.' + line[i..]
            //println('len2 ${lines[j].len}')
        //}
        println('Inserted col at $i')
        //i+=1
        gap_cols << i
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

mut pairs := 0

for stars.len > 0 {
    star := stars.pop()
    for t_star in stars {
        total += star.distance(t_star, gap_amount, gap_rows, gap_cols)
        pairs += 1
    }
    println('After $star total is $total')
}


println('Total distance $total paris $pairs')
