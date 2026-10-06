scoreboard players remove @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied 1
scoreboard players remove @s[tag=skill.selection.killer_skill] skill.slots.killer.occupied 1
scoreboard players remove @s[tag=skill.selection.weapon] skill.slots.weapon.occupied 1

$tag @s remove $(Selection)
execute if entity @s[tag=skill.selection.runner_skill] run function skill:selection/runner_gui
execute if entity @s[tag=skill.selection.killer_skill] run function skill:selection/killer_gui
execute if entity @s[tag=skill.selection.weapon] run function skill:selection/weapon_gui