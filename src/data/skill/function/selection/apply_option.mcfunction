scoreboard players reset @s skill.selection

$execute if entity @s[tag=!$(Selection)] run return run function skill:selection/equip_skill with storage skill:selection
$execute if entity @s[tag=$(Selection)] run return run function skill:selection/unequip_skill with storage skill:selection