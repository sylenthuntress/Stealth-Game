tag @s add hiding
particle minecraft:block_crumble{block_state:"minecraft:white_wool"} ~ ~ ~ 0.2 0.5 0.2 1 10 normal @a
effect give @s invisibility infinite 0 true
attribute @s minecraft:camera_distance modifier add game:gameplay/runner/hiding 1.5 add_multiplied_base
attribute @s minecraft:attack_damage modifier add game:gameplay/runner/hiding -1 add_multiplied_base
attribute @s minecraft:sneaking_speed modifier add game:gameplay/runner/hiding 0.7 add_value
attribute @s minecraft:jump_strength modifier add game:gameplay/runner/hiding -0.1 add_value
attribute @s minecraft:gravity modifier add game:gameplay/runner/hiding 0.02 add_value
attribute @s minecraft:step_height modifier add game:gameplay/runner/hiding -0.3 add_value

execute at @s run function cosmetic:hiding_form