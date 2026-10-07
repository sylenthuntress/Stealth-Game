execute if score @s[tag=skill.selection.runner_skill] skill.slots.runner.random_selected matches 1 run return run function skill:selection/locked
execute if score @s[tag=skill.selection.killer_skill] skill.slots.killer.random_selected matches 1 run return run function skill:selection/locked
execute if score @s[tag=skill.selection.weapon] skill.slots.weapon.random_selected matches 1 run return run function skill:selection/locked

scoreboard players remove @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied 1
scoreboard players remove @s[tag=skill.selection.killer_skill] skill.slots.killer.occupied 1
scoreboard players remove @s[tag=skill.selection.weapon] skill.slots.weapon.occupied 1

$data remove storage skill:selection selections[{"uid": $(uid)}].skills[{"id": "$(selectedoption)"}]
execute if entity @s[tag=skill.selection.runner_skill] run function skill:selection/runner_gui
execute if entity @s[tag=skill.selection.killer_skill] run function skill:selection/killer_gui
execute if entity @s[tag=skill.selection.weapon] run function skill:selection/weapon_gui

execute at @s run playsound minecraft:entity.item.pickup ui @s ~ ~ ~ 0.5 0.5