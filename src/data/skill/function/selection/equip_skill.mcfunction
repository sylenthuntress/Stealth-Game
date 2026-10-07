scoreboard players add @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied 1
scoreboard players add @s[tag=skill.selection.killer_skill] skill.slots.killer.occupied 1
scoreboard players add @s[tag=skill.selection.weapon] skill.slots.weapon.occupied 1

$execute unless data storage skill:selection selections[{"uid": $(uid)}] run data modify storage skill:selection selections append value {"uid": $(uid), "skills": []}
$data modify storage skill:selection selections[{"uid": $(uid)}].skills append value {"id": $(selectedoption)}

function skill:selection/refresh_gui

execute at @s run playsound minecraft:entity.item.pickup ui @s ~ ~ ~ 0.5 2