#!/usr/bin/v run

import os


fn from_count_range(maps [][]i64, from i64, count i64) (i64,i64) {
        mut didit := false
        mut lowers_start := i64(1000000000000)
        for vmap in maps {
            if from >= vmap[1] && vmap[1]+vmap[2] > from {
                if vmap[1]+vmap[2]-from >= count {
                    return vmap[0]+(from-vmap[1]), count
                } else {
                    return vmap[0]+(from-vmap[1]), vmap[1]+vmap[2]-from
                }
                if vmap[1] < lowers_start { lowers_start = vmap[2] }
            }

        }
        if from < lowers_start {
            return from, if lowers_start-from > count { count } else { lowers_start-from }
        } else {
            return from,count
        }


}

mut lines := os.read_lines('./day5.txt') or { panic(err) }

mut total := i64(0)

mut seed_map := map[i64]i64{}
mut seeds := []i64{}

mut maps := [][][]i64{}
mut state_new := false
mut start_map := -1

mut map_list := []string{}

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
        for j := 0; j < seeds.len; j += 2 {
            seed_map[seeds[j]] = seeds[j+1]
        }
        println('seeds  ${seeds}')
        println('seed_map  ${seed_map}')
        continue
    }

    if line.contains('map:') {
        map_list << line
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


for i,vmap in maps {

    mut next_seed_map := map[i64]i64{}
    println('Processing map ${map_list[i]} $vmap')

    for key,value in seed_map {
        mut start := key
        mut count := value
        for count > 0 {
            dest_from, dest_count := from_count_range(vmap, start, count)
            println('Check start=$start count=$count dest_from=$dest_from dest_count=$dest_count')
            next_seed_map[dest_from] = dest_count
            start += dest_count
            count -= dest_count
        }

    }
    println('Next seed map $next_seed_map')
    seed_map = next_seed_map.clone()
}

mut keys := seed_map.keys()
keys.sort(a < b)

println('Lowest location is ${keys[0]}')




