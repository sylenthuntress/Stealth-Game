gamemode spectator
team join dead
scoreboard players reset @s skill.runner.medic.revive_uid

# Spawn corpse
execute function game:gameplay/runner/find_ground:
    execute positioned ~ ~-0.1 ~ if block ~ ~ ~ air run function game:gameplay/runner/find_ground
    execute unless block ~ ~-0.1 ~ air run function game:gameplay/runner/spawn_corpse with entity @s

# Give killer credit
scoreboard players operation $var game.player.due_points = @s game.player.kill_threshold
scoreboard players operation $var game.player.due_points *= $10 math.const
scoreboard players operation $var game.player.due_points /= $4 math.const
scoreboard players add $var game.player.due_points 9
scoreboard players operation $var game.player.due_points /= $10 math.const
execute on attacker run scoreboard players operation @s game.player.due_points += $var game.player.due_points
execute on attacker at @s run scoreboard players operation @a[scores={game.player.team_id=2},distance=.1..] game.player.due_points += $var game.player.due_points

scoreboard players reset $var game.player.due_points
scoreboard players reset $var game.player.damage

# Play death noise
playsound minecraft:entity.bat.death player @a ~ ~ ~ 1 2 0.1