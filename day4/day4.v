#!/usr/bin/v run

import os



mut lines := os.read_lines('./day4.txt') or { panic(err) }
//mut re := regex.regex_opt(r'(\d)|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)') or { panic(err) }
//mut re_twone := regex.regex_opt(r'twone') or { panic(err) }
//mut re_oneight := regex.regex_opt(r'oneight') or { panic(err) }

mut numbers := []u8{}

mut total := 0

for line in lines {
    if line.len < 2 {
        break
    }
    //fixed_line := re_twone.replace_simple(line, '21')
    //fixed_line2 := re_oneight.replace_simple(fixed_line, '18')
    //nums := re.find_all_str(fixed_line2)
    //println('first  ${nums.len}')
    mut split_col := line.split(':')
    game_arr := split_col[0].split(' ')
    game :=  game_arr[1].u8()

    card := split_col[1].split('|')

    win_nums := card[0].split(' ').filter(it != '')
    scratch_nums := card[1].split(' ').filter(it != '')

    println('${game}:  win_nums=$win_nums scratch_nums=$scratch_nums')
    mut wins := 0

    for win in win_nums {

        if scratch_nums.contains(win) { if wins == 0 { wins = 1} else { wins += wins } }

    }

    total += wins

    println('${game}:  wins=$wins ')

    //first := nums[0]
    //last := nums[nums.len-1]
    //number := (text_to_num(first)+text_to_num(last)).u8()
    //println('${line}: first=${first} last=${last} -> number is ${number}')
    //numbers << number
}

println('Total is ${total}')

