# Deduct player's health based on taken damage
scoreboard players operation @s game.player.damage += @s data.player.damage_taken
execute if score $gamestate gamestate.runners matches 2.. run scoreboard players operation @s game.player.injury += @s data.player.damage_taken
execute if score @s game.player.damage > @s game.player.kill_threshold run scoreboard players operation @s game.player.damage = @s game.player.kill_threshold

# Give points to attacker
scoreboard players operation $var game.player.due_points = @s game.player.damage
scoreboard players operation $var game.player.due_points -= @s game.player.prev_damage
scoreboard players operation $var game.player.due_points /= $4 math.const

execute on attacker run scoreboard players operation @s game.player.due_points += $var game.player.due_points
scoreboard players reset $var game.player.due_points
scoreboard players reset $var game.player.damage

# Reveal attacker
execute on attacker expand:
    effect clear @s invisibility
    if score @s data.player.damage_dealt matches 1.. run function game:gameplay/killer/land_hit

# Kill player at high damage
execute if score @s game.player.damage = @s game.player.kill_threshold run function game:gameplay/runner/death

# Refresh health-based penalties
function game:gameplay/runner/update_injury
function game:gameplay/runner/stop_hiding

scoreboard players operation @s time.player.damage_timer += @s data.player.damage_taken
attribute @s minecraft:movement_speed modifier add game:gameplay/runner/damaged 0.1 add_value

scoreboard players operation @s game.player.prev_damage = @s game.player.damage