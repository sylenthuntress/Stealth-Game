execute at @s run playsound minecraft:block.note_block.didgeridoo ui @s ~ ~ ~ 1 0.5

scoreboard players reset @s skill.selection

function skill:selection/refresh_gui
