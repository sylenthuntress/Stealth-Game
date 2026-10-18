import skill:registry as skill_registry
# Award points to killers for timing out
scoreboard players operation $var game.player.due_points += $segments segments.elapsed
scoreboard players operation $var game.player.due_points -= $gamestate gamestate.band_progression
scoreboard players operation $var game.player.due_points *= $5 math.const
execute as @a[scores={game.player.team_id=2}] run scoreboard players operation @s game.player.due_points += $var game.player.due_points
scoreboard players reset $var game.player.due_points

# Reset each player
execute as @a run function game:round/leave_round:
    effect clear @s
    execute if entity @s[tag=hiding] run function game:gameplay/runner/stop_hiding
    function game:points/add_points

    function skill:on_disable
    function skill:disable_skills

    attribute @s minecraft:scale modifier remove game:teams/runner
    attribute @s minecraft:max_health modifier remove game:teams/runner
    attribute @s minecraft:camera_distance modifier remove game:teams/runner
    attribute @s minecraft:attack_speed modifier remove game:teams/runner
    attribute @s minecraft:movement_speed modifier remove game:teams/runner
    attribute @s minecraft:camera_distance modifier remove game:teams/killer
    attribute @s minecraft:attack_speed modifier remove game:teams/killer
    attribute @s minecraft:attack_damage modifier remove game:teams/killer
    attribute @s minecraft:movement_speed modifier remove game:teams/killer
    attribute @s minecraft:movement_speed modifier remove game:gameplay/movement_penalty/injury
    attribute @s minecraft:movement_speed modifier remove game:round/start_sequence
    attribute @s minecraft:jump_strength modifier remove game:round/start_sequence

    clear @s

scoreboard players set * game.player.points_split 1
scoreboard players reset * game.player.round_points
scoreboard players reset * game.player.band_progression
scoreboard players reset * game.player.damage
scoreboard players reset * game.player.injury
scoreboard players reset * game.player.due_points
scoreboard players reset * game.player.prev_damage
scoreboard players reset * skill.runner.medic.revive_uid
kill @e[type=item_display,tag=little_mouse]
execute as @e[type=mannequin,tag=game.runner_corpse] run function game:gameplay/runner/kill_corpse

# Put every player in spectator
gamemode spectator @a[tag=playing]

# Set variables
scoreboard players set $gamestate gamestate.round_active 0
scoreboard players set $gamestate gamestate.band_progression 0
scoreboard players set $gamestate gamestate.crossed_finish 0
scoreboard players set $time time.round_cooldown 100
scoreboard players reset $time time.start_sequence