# Tick subtasks
function game:gameplay/tick/timer

# Stop game if insufficient players
scoreboard objectives add var.player_count dummy
execute store result score $variable var.player_count run execute if entity @a[tag=playing]
execute if score $variable var.player_count matches ..1 run function game:insufficient_players:
    function game:end
    tellraw @a {"translate": "game.insufficient_players", "color": "red"}
execute if score $variable var.player_count matches ..1 return fail
scoreboard objectives remove var.player_count # Remove unneeded variable

# End round once all sneakers are spectating
execute if score $gamestate gamestate.round_active matches 1 run function game:round/tick:
    execute unless entity @a[scores={game.player.team_id=1},gamemode=!spectator] run function game:round/end
# Start round once round cooldown ends
execute if score $time time.round_cooldown matches 1.. run scoreboard players remove $time time.round_cooldown 1
execute if score $time time.round_cooldown matches 0 run function game:round/start