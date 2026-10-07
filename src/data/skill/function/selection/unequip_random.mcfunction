scoreboard players set @s[tag=skill.selection.runner_skill] skill.slots.runner.random_selected 0
scoreboard players set @s[tag=skill.selection.killer_skill] skill.slots.killer.random_selected 0
scoreboard players set @s[tag=skill.selection.weapon] skill.slots.weapon.random_selected 0
scoreboard players operation @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied -= $config config.slots.runner_skill
scoreboard players operation @s[tag=skill.selection.killer_skill] skill.slots.killer.occupied -= $config config.slots.killer_skill
scoreboard players operation @s[tag=skill.selection.weapon] skill.slots.weapon.occupied -= $config config.slots.weapon

$data remove storage skill:selection selections[{"uid": $(uid)}].skills[{"id": "$(selectedoption)"}]
execute if entity @s[tag=skill.selection.runner_skill] run function skill:selection/runner_gui
execute if entity @s[tag=skill.selection.killer_skill] run function skill:selection/killer_gui
execute if entity @s[tag=skill.selection.weapon] run function skill:selection/weapon_gui

execute at @s run playsound minecraft:block.enchantment_table.use ui @s ~ ~ ~ 0.5 2