import skill:registry as skill_registry

# Set variables
scoreboard players set $gamestate gamestate.round_active 0
scoreboard players set $gamestate gamestate.band_progression 0
scoreboard players set $time time.round_cooldown 100
scoreboard players reset $time time.start_sequence

# Reset each player
execute as @a run function game:round/leave_round:
    effect clear @s
    function game:gameplay/runner/stop_hiding

    function skill:on_disable
    function skill:disable_skills

    attribute @s minecraft:scale modifier remove game:teams/runner
    attribute @s minecraft:max_health modifier remove game:teams/runner
    attribute @s minecraft:camera_distance modifier remove game:teams/runner
    attribute @s minecraft:attack_speed modifier remove game:teams/runner
    attribute @s minecraft:camera_distance modifier remove game:teams/killer
    attribute @s minecraft:attack_speed modifier remove game:teams/killer
    attribute @s minecraft:attack_damage modifier remove game:teams/killer
    attribute @s minecraft:movement_speed modifier remove game:gameplay/movement_penalty/injury
    attribute @s minecraft:movement_speed modifier remove game:round/start_sequence
    attribute @s minecraft:jump_strength modifier remove game:round/start_sequence
scoreboard players set * game.player.band_progression 0
scoreboard players set * game.player.damage 0
scoreboard players set * game.player.prev_damage 0
kill @e[type=item_display,tag=little_mouse]

# Put every player in spectator
gamemode spectator @a[tag=playing]