execute if score @s cosmetic.selection matches -1 run function ./selection/fail_selection
execute if score @s cosmetic.selection matches 1.. run function ./selection/process_selection
execute if score @s cosmetic.switch_gui matches 1.. run function ./selection/switch_gui
execute if score @s cosmetic.close_selection matches 1 run function ./selection/gui/close