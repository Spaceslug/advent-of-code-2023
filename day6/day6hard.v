#!/usr/bin/v run

import os

fn get_distance(downtime i64, maxtime i64) i64 {
    return downtime*(maxtime-downtime)
}

mut lines := os.read_lines('./day6.txt') or { panic(err) }

mut times := []i64{}
mut distances := []i64{}

mut total := i64(1)

for i,line in lines {
    if line.len < 2 {
        break
    }

    mut split_col := line.split(':')

    if i == 0 {
        times << split_col[1].trim(' ').replace(' ', '').i64()
        println('Times $times')
    }

    if i == 1 {
        distances << split_col[1].trim(' ').replace(' ', '').i64()
        println('Distances $distances')
    }
}

for i, m_time in times {
    mut lowest := i64(0)
    mut highest := i64(0)
    for t_time := i64(0); t_time < m_time; t_time += 1 {
        dis := get_distance(t_time, m_time)
        if dis > distances[i] {
            lowest = t_time
            break
        }
    }
    //println('Wha $m_time')
    for t_time := i64(m_time); t_time > 0; t_time -= 1 {
        dis := get_distance(t_time, m_time)
        //println('What $t_time $dis')
        if dis > distances[i] {
            highest = t_time
            break
        }
    }
    total *= highest-lowest+1
    println('Race $i lowest=$lowest highest=$highest $total')
}



println('Total is ${total}')

