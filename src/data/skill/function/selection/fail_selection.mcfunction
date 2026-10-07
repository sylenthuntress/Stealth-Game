execute at @s run playsound minecraft:block.note_block.didgeridoo ui @s ~ ~ ~ 1 0.5

scoreboard players reset @s skill.selection

execute if entity @s[tag=skill.selection.runner_skill] run function skill:selection/runner_gui
execute if entity @s[tag=skill.selection.killer_skill] run function skill:selection/killer_gui
execute if entity @s[tag=skill.selection.weapon] run function skill:selection/weapon_gui