gamemode spectator
team join dead
scoreboard players reset @s skill.runner.medic.revive_uid

# Spawn corpse
execute function game:gameplay/runner/find_ground:
    execute positioned ~ ~-0.1 ~ if block ~ ~ ~ air run function game:gameplay/runner/find_ground
    execute unless block ~ ~-0.1 ~ air run function game:gameplay/runner/spawn_corpse with entity @s

# Give killer credit
execute on attacker run scoreboard players add @s game.player.due_points 15
scoreboard players add @a[scores={game.player.team_id=2}] game.player.due_points 15

# Play death noise
playsound minecraft:entity.bat.death player @a ~ ~ ~ 1 2 0.1