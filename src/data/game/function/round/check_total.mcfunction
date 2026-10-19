scoreboard objectives add var.queue dummy

execute as @a[tag=playing,sort=random,tag=!killer_blacklist] store result score @s var.queue run scoreboard players add $math gamestate.round_total 100
execute as @a[tag=playing,tag=killer_blacklist] run scoreboard players add $math gamestate.round_total 100

scoreboard players operation $math gamestate.round_total /= $100 math.const
scoreboard players operation $math gamestate.round_total *= $config config.killer_ratio

scoreboard players reset $gamestate gamestate.round_total
execute as @a[tag=playing,tag=!killer_blacklist] if score @s var.queue <= $math gamestate.round_total run scoreboard players add $gamestate gamestate.round_total 1

scoreboard objectives remove var.queue
scoreboard players reset $math gamestate.round_total

scoreboard players operation $gamestate gamestate.round_total += $gamestate gamestate.round_count