#!/usr/bin/v run

import os



mut lines := os.read_lines('./day5.txt') or { panic(err) }
//mut re := regex.regex_opt(r'(\d)|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)') or { panic(err) }
//mut re_twone := regex.regex_opt(r'twone') or { panic(err) }
//mut re_oneight := regex.regex_opt(r'oneight') or { panic(err) }

mut total := i64(0)

mut seeds := []i64{}

mut maps := [][][]i64{}
mut state_new := false
mut start_map := -1

for i, line in lines {
    if line.len < 2 {
        if start_map >= 0 {
            println('finished map ${maps[start_map]}')
        }
        continue
    }

    if line.contains('seeds:') {
        mut split := line.split(':')
        seeds = split[1].split(' ').filter(it != '').map(it.i64())
        println('seeds  ${seeds}')
        continue
    }

    if line.contains('map:') {
        start_map += 1
        maps.insert(start_map, [][]i64{})
        println('new map: $line')
        continue
    }

    numbers_str := line.split(' ')

    if numbers_str.len == 3 {

        maps[start_map] << numbers_str.map(it.i64())
    }
}

seeds_map := [][]i64{len: seeds.len, init: []i64{len: maps.len, init: 0}}

for i, seed in seeds {
    mut last := seed
    for j, mut s_map in seeds_map[i64(i)] {
        mut didit := false
        for j_map in maps[j] {
            if j_map[1] <= last && j_map[1]+j_map[2] > last {
                s_map = j_map[0] + (last - j_map[1])
                last = s_map
                println('${seeds_map[i]}')
                didit = true
                break
            }

        }
        if !didit {
            s_map = last
            last = s_map
            println('${seeds_map[i]}')
        }
    }
    println('${seeds_map[i]}')
}


mut final_list := seeds_map.map(it[it.len-1])

println('Final list ${final_list}')
final_list.sort(a < b)
total = final_list[0]

println('Lowest value ${total}')

