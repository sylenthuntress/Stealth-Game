execute if score @s[tag=cosmetic.selection.main] cosmetic.switch_gui matches 1 run function ./gui/runner_skin
execute if score @s[tag=cosmetic.selection.main] cosmetic.switch_gui matches 2 run function ./gui/killer_skin
tag @s remove cosmetic.selection.main
scoreboard players reset @s cosmetic.switch_gui