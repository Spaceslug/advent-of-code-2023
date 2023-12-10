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


mut rekke := [][]int{}

mut total := int(0)
          println('deawge')

for line in lines {
          println('deawge')

    rekke << line.split(' ').map(it.int())
              println('deawge')
	rekke[0] = rekke[0].reverse()

    mut i := 0
    for !rekke[i].all(it==0) {
        mut aa := foldr(rekke[i], []int{}, fn (r []int, a int) []int {
          mut rc := r.clone()
          if rc.len != 0 {  rc[rc.len-1] = a - rc.last()  }
          rc << a
          return rc
        })
        aa.delete(aa.len-1)
        rekke << aa
        println('${rekke[i]}')
        i += 1
    }

    for i > 0 {
        rekke[i-1] << rekke[i-1].last() + rekke[i].last()
        println('${rekke[i-1].last()}')
        i -= 1
    }
    total += rekke[0].last()
    println('total $total')

    rekke = [][]int{}
}



println('Total is ${total}')

