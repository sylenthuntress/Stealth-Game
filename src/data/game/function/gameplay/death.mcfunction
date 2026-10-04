# Enter spectator
gamemode spectator
team join dead

# Give killer credit
execute on attacker run scoreboard players add @s game.player.points 15
scoreboard players add @a[scores={game.player.team_id=2}] game.player.points 15