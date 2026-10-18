# Award points to killers for timing out
scoreboard players operation $var game.player.due_points += $segments segments.elapsed
scoreboard players operation $var game.player.due_points -= $gamestate gamestate.band_progression
scoreboard players operation $var game.player.due_points *= $5 math.const
execute as @a[scores={game.player.team_id=2}] run scoreboard players operation @s game.player.due_points += $var game.player.due_points
scoreboard players reset $var game.player.due_points

# End round
function game:round/end