execute if score @s[predicate=util:is_sneaking] time.player.hide_timer matches 15..197 run scoreboard players add @s time.player.hide_timer 3

execute if entity @s[tag=hiding] run function skill:runner_skill/camouflage/while_hiding:
    attribute @s minecraft:jump_strength modifier add game:runner_skill/camouflage/hiding 0.07 add_value
    attribute @s minecraft:gravity modifier add game:runner_skill/camouflage/hiding -0.01 add_value
    attribute @s minecraft:step_height modifier add game:runner_skill/camouflage/hiding 0.2 add_value

execute if entity @s[tag=!hiding] run function skill:runner_skill/camouflage/not_hiding:
    attribute @s minecraft:jump_strength modifier remove game:runner_skill/camouflage/hiding
    attribute @s minecraft:gravity modifier remove game:runner_skill/camouflage/hiding
    attribute @s minecraft:step_height modifier remove game:runner_skill/camouflage/hiding