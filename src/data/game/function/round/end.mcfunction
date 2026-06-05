# Set variables
scoreboard players set $gamestate gamestate.round_active 0
scoreboard players set $time time.round_cooldown 100

# Reset each player
execute as @a[scores={game.player.team_id=1}] run function game:round/leave_round:
    effect clear @s
    execute as @a[tag=playing] run attribute @s minecraft:scale modifier remove game:teams/sneaker
    execute as @a[tag=playing] run attribute @s minecraft:max_health modifier remove game:teams/sneaker

# Put every player in spectator
gamemode spectator @a[tag=playing]