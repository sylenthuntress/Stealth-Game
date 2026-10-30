import skill:registry as registry

execute store result storage skill:data Selection.selector.selectedoption int 1 run scoreboard players get @s skill.selection

function skill:selection/find_option with storage skill:data Selection.selector