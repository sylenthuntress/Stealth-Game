execute if score $config config.slots.runner_skill <= @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied run return run function skill:selection/runner_gui
execute if score  $config config.slots.killer_skill <= @s[tag=skill.selection.killer_skill]skill.slots.killer.occupied run return run function skill:selection/killer_gui
execute if score $config config.slots.weapon <= @s[tag=skill.selection.weapon] skill.slots.weapon.occupied run return run function skill:selection/weapon_gui

scoreboard players add @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied 1
scoreboard players add @s[tag=skill.selection.killer_skill] skill.slots.killer.occupied 1
scoreboard players add @s[tag=skill.selection.weapon] skill.slots.weapon.occupied 1

$tag @s add $(Selection)
execute if entity @s[tag=skill.selection.runner_skill] run function skill:selection/runner_gui
execute if entity @s[tag=skill.selection.killer_skill] run function skill:selection/killer_gui
execute if entity @s[tag=skill.selection.weapon] run function skill:selection/weapon_gui