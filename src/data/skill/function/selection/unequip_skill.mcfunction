scoreboard players remove @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied 1
scoreboard players remove @s[tag=skill.selection.killer_skill] skill.slots.killer.occupied 1
scoreboard players remove @s[tag=skill.selection.weapon] skill.slots.weapon.occupied 1

$data remove storage skill:selection selections[{"uid": $(uid)}].skills[{"id": "$(selectedoption)"}]
function skill:selection/refresh_gui

execute at @s run playsound minecraft:entity.item.pickup ui @s ~ ~ ~ 0.5 0.5