import util:coordinates as coords

# Set variables
scoreboard players add $gamestate gamestate.round_count 1
scoreboard players set $time time.start_sequence 300
scoreboard players reset $time time.round_cooldown
scoreboard players reset $time time.round_timer
bossbar set game:time/round_timer players
execute as @e[type=text_display,tag=band_display] run data modify entity @s text.color set value red
function game:points/clear_logs

# Distribute teams for everyone
scoreboard players reset @a game.player.team_id

execute if score $config config.team_selection matches 0 expand:
    scoreboard players set @a[tag=playing] game.player.team_id 1
    scoreboard players set $queue game.player.killer_queue 999
    execute as @a[tag=playing] if score @s game.player.killer_queue matches 1.. run scoreboard players operation $queue game.player.killer_queue < @s game.player.killer_queue
    execute as @a[tag=playing] if score @s game.player.killer_queue = $queue game.player.killer_queue expand:
        scoreboard players set @s game.player.team_id 2
        scoreboard players reset @s game.player.killer_queue
execute store result score $gamestate gamestate.runners if entity @a[scores={game.player.team_id=1}]
execute store result score $gamestate gamestate.killers if entity @a[scores={game.player.team_id=2}]

team leave @a[tag=playing]
execute as @a[tag=playing] run function game:round/join_round:
    effect clear @s
    effect give @s regeneration infinite 255 true
    effect give @s saturation infinite 255 true
    effect give @s instant_health 1 255 true

    attribute @s minecraft:movement_speed modifier add game:round/start_sequence -1 add_multiplied_total
    attribute @s minecraft:jump_strength modifier add game:round/start_sequence -1 add_multiplied_total
    function render:points/make_numberformat
execute as @a[scores={game.player.team_id=1}] run function game:round/join_runner:
    gamemode adventure @s
    team join runner @s
    function skill:selection/runner_gui
    effect give @s invisibility 17 0 true
    attribute @s minecraft:scale modifier add game:teams/runner -0.33 add_value
    attribute @s minecraft:max_health modifier add game:teams/runner 79 add_value
    attribute @s minecraft:camera_distance modifier add game:teams/runner -1.5 add_value
    attribute @s minecraft:attack_speed modifier add game:teams/runner 100 add_value

    scoreboard players set @s game.player.kill_threshold 300

    scoreboard players operation $math gamestate.runners = $gamestate gamestate.runners
    scoreboard players operation $math gamestate.runners /= $2 math.const
    scoreboard players add $math gamestate.runners 1
    scoreboard players operation @s game.player.kill_threshold /= $math gamestate.runners
    scoreboard players reset $math gamestate.runners

    scoreboard players operation @s game.player.kill_threshold *= $gamestate gamestate.killers

    execute if score @s game.player.kill_threshold matches ..50 run scoreboard players set @s game.player.kill_threshold 50

    tp @s coords.runner_spawn.x coords.runner_spawn.y coords.runner_spawn.z
execute as @a[scores={game.player.team_id=2}] run function game:round/join_killer:
    gamemode adventure @s
    team join killer @s
    function skill:selection/killer_gui
    attribute @s minecraft:camera_distance modifier add game:teams/killer -3.5 add_value
    attribute @s minecraft:attack_damage modifier add game:teams/killer 2 add_value
    attribute @s minecraft:attack_speed modifier add game:teams/killer 100 add_value
    attribute @s minecraft:movement_speed modifier add game:teams/killer 0.15 add_multiplied_base

    tp @s coords.killer_spawn.x coords.killer_spawn.y coords.killer_spawn.z

# Update round total
function game:round/check_total

# End game if no runner/killer is found
execute unless entity @a[team=runner] run function game:end
execute unless entity @a[team=runner] run return fail

execute unless entity @a[team=killer] run function game:end
execute unless entity @a[team=killer] run return fail