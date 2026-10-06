scoreboard players reset @s skill.selection

$execute unless data storage skill:selection selections[{"uid": $(uid)}].skills[{"id": "$(selectedoption)"}] run return run function skill:selection/equip_skill with storage skill:selection selector
$execute if data storage skill:selection selections[{"uid": $(uid)}].skills[{"id": "$(selectedoption)"}] run return run function skill:selection/unequip_skill with storage skill:selection selector