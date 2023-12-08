#!/usr/bin/v run

import os
import math
import arrays

struct Move {
	left  string
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
	linea := line.replace(' ', '')
	split := linea.split('=')

	split2 := split[1].split(',')
	move_map[split[0]] = Move{
		left: split2[0].replace('(', '')
		right: split2[1].replace(')', '')
	}
}

mut nexts := []string{}
for key, _ in move_map {
	if key[2] == `A` {
		nexts << key
	}
}
mut start_places := nexts.clone()
mut periods := map[string]int{}

for periods.len != nexts.len {
	mut moves := []Move{}
	for next in nexts {
		moves << move_map[next]
	}
	for i, move in moves {
		if periods[start_places[i]] != 0 {
			continue
		}
		if instructions[total % instructions.len] == `L` {
			nexts[i] = move.left
		} else {
			nexts[i] = move.right
		}
		if nexts[i][2] == `Z` {
			periods[start_places[i]] = total+1
		}
	}
	total += 1

}
lcm := arrays.reduce(periods.values().map(i64(it)), fn (a i64, b i64) i64 {
	return math.lcm(a, b)
})!

println('Total is ${total}   LCM ${lcm}')
