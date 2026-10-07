data modify storage skill:selection Options append value {"label": {"translate": "", with: [{"atlas": "", "sprite": "", "color": "white"}]}, "tooltip": {"translate": ""}, width: 100, action: {"type": "minecraft:run_command", "command": ""}}
data modify storage skill:selection Options[-1].label.translate set from storage skill:selection Recursive[0].id
data modify storage skill:selection Options[-1].label.with[0].sprite set from storage skill:selection Recursive[0].icon
data modify storage skill:selection Options[-1].label.with[0].atlas set from storage skill:selection Recursive[0].atlas
data modify storage skill:selection Options[-1].tooltip.translate set from storage skill:selection Recursive[0].desc

function skill:selection/set_command with storage skill:selection Recursive[0]

execute store result storage skill:selection Recursive[0].uid int 1 run scoreboard players get @s uid.player 

execute if score $config config.slots.runner_skill <= @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied run function skill:selection/lock_option with storage skill:selection Recursive[0]
execute if score $config config.slots.killer_skill <= @s[tag=skill.selection.killer_skill] skill.slots.killer.occupied run function skill:selection/lock_option with storage skill:selection Recursive[0]
execute if score $config config.slots.weapon <= @s[tag=skill.selection.weapon] skill.slots.weapon.occupied run function skill:selection/lock_option with storage skill:selection Recursive[0]

execute unless data storage skill:selection Recursive[0].is_random unless score @s[tag=skill.selection.runner_skill] skill.slots.runner.random_selected matches 1 run function skill:selection/make_equipped_option with storage skill:selection Recursive[0]
execute unless data storage skill:selection Recursive[0].is_random unless score @s[tag=skill.selection.killer_skill] skill.slots.killer.random_selected matches 1 run function skill:selection/make_equipped_option with storage skill:selection Recursive[0]
execute unless data storage skill:selection Recursive[0].is_random unless score @s[tag=skill.selection.weapon] skill.slots.weapon.random_selected matches 1 run function skill:selection/make_equipped_option with storage skill:selection Recursive[0]
execute if data storage skill:selection Recursive[0].is_random run function skill:selection/make_equipped_option with storage skill:selection Recursive[0]

data remove storage skill:selection Recursive[0]
execute if data storage skill:selection Recursive[0] run function skill:selection/make_options