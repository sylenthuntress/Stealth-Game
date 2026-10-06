$execute if entity @s[tag=skill.selection.runner_skill] run data modify storage skill:selection selector.selectedoption set from storage skill:registry RunnerSkills[{"numid":$(selectedoption)}].id
$execute if entity @s[tag=skill.selection.killer_skill] run data modify storage skill:selection selector.selectedoption set from storage skill:registry KillerSkills[{"numid":$(selectedoption)}].id
$execute if entity @s[tag=skill.selection.weapon] run data modify storage skill:selection selector.selectedoption set from storage skill:registry WeaponRegistry[{"numid":$(selectedoption)}].id

execute store result storage skill:selection selector.uid int 1 run scoreboard players get @s uid.player

function skill:selection/select_option with storage skill:selection selector