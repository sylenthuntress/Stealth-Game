scoreboard players set @s[tag=skill.selection.runner_skill] skill.slots.runner.random_selected 1
scoreboard players set @s[tag=skill.selection.killer_skill] skill.slots.killer.random_selected 1
scoreboard players set @s[tag=skill.selection.weapon] skill.slots.weapon.random_selected 1

scoreboard players operation @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied += $config config.slots.runner_skill
scoreboard players operation @s[tag=skill.selection.killer_skill] skill.slots.killer.occupied += $config config.slots.killer_skill
scoreboard players operation @s[tag=skill.selection.weapon] skill.slots.weapon.occupied += $config config.slots.weapon

$execute unless data storage skill:selection selections[{"uid": $(uid)}] run data modify storage skill:selection selections append value {"uid": $(uid), "skills": []}
$data modify storage skill:selection selections[{"uid": $(uid)}].skills append value {"id": $(selectedoption), "is_random": 1}

execute if entity @s[tag=skill.selection.runner_skill] run function skill:selection/runner_gui
execute if entity @s[tag=skill.selection.killer_skill] run function skill:selection/killer_gui
execute if entity @s[tag=skill.selection.weapon] run function skill:selection/weapon_gui

execute at @s run playsound minecraft:block.enchantment_table.use ui @s ~ ~ ~ 0.5 0.5