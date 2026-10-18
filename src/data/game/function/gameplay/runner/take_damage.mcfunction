# Deduct player's health based on taken damage
scoreboard players operation @s game.player.damage += @s data.player.damage_taken
execute if score $gamestate gamestate.runners matches 2.. run scoreboard players operation @s game.player.injury += @s data.player.damage_taken
execute if score @s game.player.damage > @s game.player.kill_threshold run scoreboard players operation @s game.player.damage = @s game.player.kill_threshold

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

# Give speed boost
scoreboard players operation @s time.player.damage_timer += @s data.player.damage_taken
attribute @s minecraft:movement_speed modifier add game:gameplay/runner/damaged 0.1 add_value

# Reveal attacker
execute on attacker run effect clear @s invisibility

# Kill player at high damage
execute if score @s game.player.damage = @s game.player.kill_threshold run function game:gameplay/runner/death

# Refresh health-based penalties
function game:gameplay/runner/update_injury
function game:gameplay/runner/stop_hiding