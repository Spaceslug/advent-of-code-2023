#!/usr/bin/v run

import os


 
mut lines := os.read_lines('./day2.txt') or { panic(err) }
//mut re := regex.regex_opt(r'(\d)|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)') or { panic(err) }
//mut re_twone := regex.regex_opt(r'twone') or { panic(err) }
//mut re_oneight := regex.regex_opt(r'oneight') or { panic(err) }

mut numbers := []u8

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
    
    picks := split_col[1].split(';')

    println('${game}:  line="${line}"')


    mut most := {
        'green': 0
        'blue': 0
        'red': 0
    }

    mut num_picks := 1
    for pick in picks {
        cubes := pick.split(',')

        //println('pick ${num_picks}: ${cubes}:')


        for cube in cubes {
            color := cube.trim(' ').split(' ')
            //println('COLOR=${color}')
            if color[1] == 'red' && most['red'] < color[0].u8() {
                println('larger red ${color[0]}')
                most['red'] = color[0].u8()
            }
            if color[1] == 'blue' && most['blue'] < color[0].u8() {
                println('larger blue ${color[0]}')
                most['blue'] = color[0].u8()
            }
            if color[1] == 'green' && most['green'] < color[0].u8() {
                println('larger green ${color[0]}')
                most['green'] = color[0].u8()
            }
        }

        num_picks += 1
    }

    max_red := 12
    max_green := 13
    max_blue := 14

    if most['red'] <= max_red && most['green'] <= max_green && most['blue'] <= max_blue {
        println('${game}: is valid!')
        total += game
    }


    //first := nums[0]
    //last := nums[nums.len-1]
    //number := (text_to_num(first)+text_to_num(last)).u8()
    //println('${line}: first=${first} last=${last} -> number is ${number}')
    //numbers << number
}

println('Total is ${total}')

