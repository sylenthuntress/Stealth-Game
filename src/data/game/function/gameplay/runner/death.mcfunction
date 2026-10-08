# Enter spectator
gamemode spectator
team join dead

# Give killer credit
execute on attacker run scoreboard players add @s game.player.due_points 15
scoreboard players add @a[scores={game.player.team_id=2}] game.player.due_points 15

# Play death noise
playsound minecraft:entity.bat.death player @a ~ ~ ~ 1 2 0.1