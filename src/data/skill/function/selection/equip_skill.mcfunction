scoreboard players add @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied 1
scoreboard players add @s[tag=skill.selection.killer_skill] skill.slots.killer.occupied 1
scoreboard players add @s[tag=skill.selection.weapon] skill.slots.weapon.occupied 1

$data modify storage skill:selection selections[{"uid": $(uid)}].skills append value {"id": "$(selected_id)", "desc": "$(selected_desc)", "icon": "$(selected_icon)", "atlas": "$(selected_atlas)"}

$execute if entity @s[tag=skill.selection.runner_skill] run data modify storage skill:selection selections[{"uid": $(uid)}].skills[-1].runner_skill set value true 
$execute if entity @s[tag=skill.selection.killer_skill] run data modify storage skill:selection selections[{"uid": $(uid)}].skills[-1].killer_skill set value true 
$execute if entity @s[tag=skill.selection.weapon] run data modify storage skill:selection selections[{"uid": $(uid)}].skills[-1].weapon set value true 

function skill:selection/refresh_gui

execute at @s run playsound minecraft:entity.item.pickup ui @s ~ ~ ~ 0.5 2