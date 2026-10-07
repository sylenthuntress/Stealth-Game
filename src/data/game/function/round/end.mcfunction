# Set variables
scoreboard players set $gamestate gamestate.round_active 0
scoreboard players set $gamestate gamestate.band_progression 0
scoreboard players set $time time.round_cooldown 100

# Reset each player
execute as @a run function game:round/leave_round:
    effect clear @s
    function game:gameplay/runner/stop_hiding
    function skill:disable_skills
    attribute @s minecraft:scale modifier remove game:teams/sneaker
    attribute @s minecraft:max_health modifier remove game:teams/sneaker
    attribute @s minecraft:camera_distance modifier remove game:teams/sneaker
    attribute @s minecraft:camera_distance modifier remove game:teams/killer
    attribute @s minecraft:movement_speed modifier remove game:gameplay/movement_penalty/injury
scoreboard players set * game.player.band_progression 0
scoreboard players set * game.player.damage 0

# Put every player in spectator
gamemode spectator @a[tag=playing]