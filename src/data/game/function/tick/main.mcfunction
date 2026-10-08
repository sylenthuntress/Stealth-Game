# Tick subtasks
execute if score $gamestate gamestate.round_active matches 1 run function game:gameplay/tick/main
function render:tick/main

# Stop game if insufficient players
scoreboard objectives add var.players dummy
execute store result score $var var.players run execute if entity @a[tag=playing]
execute if score $var var.players matches ..1 run function game:insufficient_players:
    function game:end
    tellraw @a {"translate": "game.insufficient_players", "color": "red"}
execute if score $var var.players matches ..1 return fail

# End round once all runners are spectating
execute if score $gamestate gamestate.round_active matches 1 run function game:round/tick:
    execute unless entity @a[scores={game.player.team_id=1},gamemode=!spectator] run function game:round/end
    
# Start round once round cooldown ends
execute store result score $gamestate gamestate.round_total run execute if entity @a[tag=!killer_blacklist] 
scoreboard players operation $gamestate gamestate.round_total += $gamestate gamestate.round_count

execute if score $time time.round_cooldown matches 1.. run scoreboard players remove $time time.round_cooldown 1
execute if score $time time.round_cooldown matches 0 unless score $gamestate gamestate.round_count = $gamestate gamestate.round_total run function game:round/new_round
execute if score $time time.round_cooldown matches 0 if score $gamestate gamestate.round_count = $gamestate gamestate.round_total run return run function game:end # End game once rounds exceed available players

execute if score $time time.start_sequence matches 0.. run function game:round/start_sequence

# Manage spectators
# execute as @a[gamemode=spectator] at @s if block ~ 41 ~ minecraft:black_concrete run function game:leash_spectator:
#    tp @p[gamemode=!spectator,tag=playing]
#    title @s actionbar {"translate": "game.spectator.too_far", "color": "red"}
#    execute at @s run playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 2 0.5
# execute as @a[gamemode=spectator,y=100,distance=..20] run function game:leash_spectator

# Remove unneded variables
scoreboard objectives remove var.players