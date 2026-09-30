# Tick subtasks
function game:gameplay/tick/main
function render:tick/main

# Stop game if insufficient players
scoreboard objectives add var.players dummy
execute store result score $var var.players run execute if entity @a[tag=playing]
execute if score $var var.players matches ..1 run function game:insufficient_players:
    function game:end
    tellraw @a {"translate": "game.insufficient_players", "color": "red"}
execute if score $var var.players matches ..1 return fail
scoreboard objectives remove var.players # Remove unneeded variable

# End round once all sneakers are spectating
execute if score $gamestate gamestate.round_active matches 1 run function game:round/tick:
    execute unless entity @a[scores={game.player.team_id=1},gamemode=!spectator] run function game:round/end
# Start round once round cooldown ends
execute if score $time time.round_cooldown matches 1.. run scoreboard players remove $time time.round_cooldown 1
execute if score $time time.round_cooldown matches 0 run function game:round/start

# Manage spectators
execute as @a[gamemode=spectator] at @s if entity @a[gamemode=!spectator,tag=playing] unless entity @a[gamemode=!spectator,distance=..32] run function game:leash_spectator:
    spectate @p[gamemode=!spectator]
    title @s actionbar {"translate": "game.spectator.too_far", "color": "red"}
    playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 2 0.7