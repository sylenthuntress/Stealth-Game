import skill:registry as registry

execute if score @s skill.selection matches -1 run function skill:selection/fail_selection
execute if score @s skill.selection matches 1.. run function skill:selection/process_selection
execute if score @s skill.switch_selection matches 1.. run function skill:selection/switch_gui
execute if score @s skill.close_selection matches 1 run function skill:selection/close_gui

for function in registry.getFunctions():
    execute if entity @s[tag=function.tag] run function (function.path + "main")