scoreboard players add @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied 1
scoreboard players add @s[tag=skill.selection.killer_skill] skill.slots.killer.occupied 1
scoreboard players add @s[tag=skill.selection.weapon] skill.slots.weapon.occupied 1

$data modify storage skill:data Selection.players[{"uid": $(uid)}].skills append from storage skill:data Registry[{"numid":$(selectedoption)}]

function skill:selection/refresh_gui

execute at @s run playsound minecraft:entity.item.pickup ui @s ~ ~ ~ 0.5 2