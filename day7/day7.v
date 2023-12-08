#!/usr/bin/v run

import os
import arrays


mut lines := os.read_lines('./day7.txt') or { panic(err) }

mut cards := []string{}
mut card_to_score := map[string]int{}

mut total := i64(0)

for line in lines {
    split := line.split(' ')
    cards << split[0]
    card_to_score[split[0]] = split[1].int()
}


hand_sort_fn := fn (a &string, b &string) int {
    // return -1 when a comes before b
    // return 0, when both are in same order
    // return 1 when b comes before a
    card_sort_fn := fn (a &rune, b &rune) int {
        rune_map := {`A`:13,`K`:12,`Q`:11,`J`:10,`T`:9,`9`:8,`8`:7,`7`:6,`6`:5,`5`:4,`4`:3,`3`:2,`2`:1}
        a_int := rune_map[*a]
        b_int := rune_map[*b]
        if a_int > b_int { return -1 }
        if a_int < b_int { return 1 }
        return 0

    }
    a_runes := a.runes()
    b_runes := b.runes()

    mut a_pairs := arrays.map_of_counts(a_runes).values()
    a_pairs.sort(a > b)
    mut b_pairs := arrays.map_of_counts(b_runes).values()
    b_pairs.sort(a > b)
    if a_pairs.len < b_pairs.len { return -1 } else if a_pairs.len > b_pairs.len { return 1 }
    if a_pairs.len < b_pairs.len { return -1 } else if a_pairs.len > b_pairs.len { return 1 }
    for a_pairs.len > 0 {
        if a_pairs.first() > b_pairs.first() { return -1 } else if a_pairs.first() < b_pairs.first() { return 1 }
        a_pairs.delete(0)
        b_pairs.delete(0)
    }
    for i in 0..a_runes.len {
        comp := card_sort_fn(a_runes[i], b_runes[i])
        if comp != 0 { return comp }
    }
    return 0
}

println('cards $cards')
println('card_to_score $card_to_score')

cards.sort_with_compare(hand_sort_fn)

println('sorted cards $cards')

for i, card in cards {
    total += (cards.len-i) * card_to_score[card]
}


println('Total is ${total}')

