execute as @a if score @s skill.selection matches 1.. run function skill:selection/process_selection
execute as @a if score @s skill.switch_selection matches 1.. run function skill:selection/switch_gui
execute as @a if score @s skill.close_selection matches 1 run function skill:selection/close_gui