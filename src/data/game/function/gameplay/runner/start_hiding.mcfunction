execute unless score @s uid.hiding_form matches 0.. store result score @s uid.hiding_form run scoreboard players add #uid.index uid.hiding_form 1 

tag @s add hiding
item fill entity @s armor.* with air
attribute @s minecraft:camera_distance modifier add game:gameplay/runner/hiding 1.5 add_multiplied_base
attribute @s minecraft:sneaking_speed modifier add game:gameplay/runner/hiding 0.7 add_value
attribute @s minecraft:jump_strength modifier add game:gameplay/runner/hiding -0.1 add_value
attribute @s minecraft:gravity modifier add game:gameplay/runner/hiding 0.02 add_value
attribute @s minecraft:step_height modifier add game:gameplay/runner/hiding -0.3 add_value

execute at @s run function cosmetic:effects/hiding_form