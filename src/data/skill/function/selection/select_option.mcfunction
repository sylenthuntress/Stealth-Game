scoreboard players reset @s skill.selection

$execute unless data storage skill:data Selection.players[{"uid": $(uid)}].skills[{"numid": $(selectedoption)}] run return run function skill:selection/equip_skill with storage skill:data Selection.selector
$execute if data storage skill:data Selection.players[{"uid": $(uid)}].skills[{"numid": $(selectedoption)}] run return run function skill:selection/unequip_skill with storage skill:data Selection.selector