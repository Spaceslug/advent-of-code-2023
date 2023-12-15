#!/usr/bin/env -S v run

import arrays

pub fn foldr[T, R](array []T, init R, fold_op fn (acc R, elem T) R) R {
    unsafe {
         mut value := init
         for e in array {
             value = fold_op(value, e)
        }
        return value
    }
}



mut lines := read_lines('./input.txt') or { panic(err) }

bits := lines[0].split(',')
hashes := bits.map(foldr(it.bytes(), u8(0), fn (h u8, e u8) u8 { return u8((int(h) + e) * 17 % 256) }))

println('$bits')
println('$hashes')

total := foldr(hashes, 0, fn (a int, x u8) int { return a + x})


println('Total distance $total ')
