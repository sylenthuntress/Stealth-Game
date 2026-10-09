# Deduct player's health based on taken damage
scoreboard players operation @s game.player.damage += @s data.player.damage_taken
scoreboard players operation @s game.player.injury += @s data.player.damage_taken
execute if score @s game.player.damage matches 200.. run scoreboard players set @s game.player.damage 200

# Give points to attacker
scoreboard players operation $var game.player.due_points += @s game.player.damage
scoreboard players operation $var game.player.due_points -= @s game.player.prev_damage

scoreboard objectives add var.runners dummy
scoreboard players operation $var var.runners = $gamestate gamestate.runners
scoreboard players add $var var.runners 1
scoreboard players operation $var game.player.due_points /= $var var.runners
scoreboard objectives remove var.runners

execute on attacker run scoreboard players operation @s game.player.due_points += $var game.player.due_points
scoreboard players reset $var game.player.due_points
scoreboard players operation @s game.player.prev_damage = @s game.player.damage

# Kill player at high damage
execute if score @s game.player.damage matches 200 run function game:gameplay/runner/death

# Refresh health-based penalties
function game:gameplay/runner/update_health
function game:gameplay/runner/stop_hiding