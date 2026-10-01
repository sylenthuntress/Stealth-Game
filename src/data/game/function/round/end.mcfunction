# Set variables
scoreboard players set $gamestate gamestate.round_active 0
scoreboard players set $gamestate gamestate.band_progression 0
scoreboard players set $time time.round_cooldown 100

# Reset each player
execute as @a run function game:round/leave_round:
    effect clear @s
    attribute @s minecraft:scale modifier remove game:teams/sneaker
    attribute @s minecraft:max_health modifier remove game:teams/sneaker
    attribute @s minecraft:camera_distance modifier remove game:teams/sneaker
    attribute @s minecraft:camera_distance modifier remove game:teams/killer
    scoreboard players set @s game.player.band_progression 0

# Put every player in spectator
gamemode spectator @a[tag=playing]