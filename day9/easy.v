#!/usr/bin/v run

import os

struct Move {
    left string
    right string
}

mut lines := os.read_lines('./day8.txt') or { panic(err) }

mut instructions := ''
mut move_map := map[string]Move{}

mut total := int(0)

instructions = lines[0]
lines.delete(0)
lines.delete(0)

for line in lines {
    linea := line.replace(' ','')
    split := linea.split('=')

    split2 := split[1].split(',')
    move := Move{left: split2[0].replace('(',''),right:split2[1].replace(')','')}
    move_map[split[0]] = move

}

mut next := 'AAA'
mut dest := 'ZZZ'

for {
    move_bit := instructions[total%instructions.len]
    move := move_map[next]
    total += 1
    if move_bit == 'L'[0] {
        next = move.left
        println('Total: $total Move left $next')
    } else {
        next = move.right
        println('Total: $total Move right $next')
    }
    if next == dest {
        break
    }
    if total == 30000000 {
        break
    }
}

println('Total is ${total}')

