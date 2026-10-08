# Set Variables
scoreboard players set $gamestate gamestate.round_active 1
scoreboard players reset $time time.start_sequence

# Set timer
execute as @e[type=text_display,tag=band_display] run data modify entity @s text.color set value red
    # Setup round timer
    execute store result score $time time.round_timer run function util:get/base_timer
    execute store result bossbar game:time/round_timer max run scoreboard players get $time time.round_timer
    bossbar set game:time/round_timer players @a[tag=playing]

execute as @a[tag=playing] at @s run function game:round/start_moving:
    attribute @s minecraft:movement_speed modifier remove game:round/start_sequence
    attribute @s minecraft:jump_strength modifier remove game:round/start_sequence
    # Enable skills
    function skill:selection/close_gui
    function skill:enable_skills
    function skill:on_enable

    # Play FX
    playsound minecraft:entity.experience_orb.pickup ui @s ~ ~ ~ 1 1