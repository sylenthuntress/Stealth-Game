import util:coordinates as coords

# Set variables
scoreboard players add $gamestate gamestate.round_count 1
scoreboard players set $gamestate gamestate.round_active 1
scoreboard players reset $time time.round_cooldown
execute as @e[type=text_display,tag=band_display] run data modify entity @s text.color set value red
    # Setup round timer
    execute store result score $time time.round_timer run function util:get/base_timer
    execute store result bossbar game:time/round_timer max run scoreboard players get $time time.round_timer
        # Set bossbar visibility
        execute as @a[tag=playing] run tag @s add temp
        bossbar set game:time/round_timer players @a[tag=temp]
        tag @a remove temp

# Distribute teams for everyone
scoreboard players reset @a game.player.team_id

execute if score $config config.team_selection matches 0 run scoreboard players set @a[tag=playing] game.player.team_id 1
execute if score $config config.team_selection matches 0 run function game:round/random_teams

team leave @a[tag=playing]
execute as @a[scores={game.player.team_id=1}] run function game:round/join_sneaker:
    gamemode adventure @s
    team join sneaker @s
    attribute @s minecraft:scale modifier add game:teams/sneaker -0.33 add_value
    attribute @s minecraft:max_health modifier add game:teams/sneaker 79 add_value
    attribute @s minecraft:camera_distance modifier add game:teams/sneaker -1.5 add_value

    tp @s coords.sneaker_spawn.x coords.sneaker_spawn.y coords.sneaker_spawn.z
execute as @a[scores={game.player.team_id=2}] run function game:round/join_killer:
    gamemode adventure @s
    team join killer @s
    attribute @s minecraft:camera_distance modifier add game:teams/killer -3.5 add_value

    tp @s coords.killer_spawn.x coords.killer_spawn.y coords.killer_spawn.z
execute as @a[tag=playing] run function game:round/join_round:
    effect give @s regeneration infinite 255 true
    effect give @s instant_health 1 255 true
    effect clear @s blindness
    effect clear @s invisibility

# End game if no sneaker/killer is found
execute unless entity @a[team=sneaker] run function game:end
execute unless entity @a[team=sneaker] run return fail

execute unless entity @a[team=killer] run function game:end
execute unless entity @a[team=killer] run return fail