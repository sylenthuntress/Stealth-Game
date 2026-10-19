scoreboard objectives add var.queue dummy

scoreboard players reset $gamestate gamestate.round_total
execute as @a[tag=playing] run scoreboard players operation $gamestate gamestate.round_total > @s game.player.killer_queue