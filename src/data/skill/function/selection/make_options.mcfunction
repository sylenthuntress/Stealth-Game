data modify storage skill:selection Options append value {"label": {"translate": "", with: [{"atlas": "", "sprite": "", "color": "white"}]}, "tooltip": {"translate": ""}, width: 100, action: {"type": "minecraft:run_command", "command": ""}}
data modify storage skill:selection Options[-1].label.translate set from storage skill:registry Recursive[0].id
data modify storage skill:selection Options[-1].label.with[0].sprite set from storage skill:registry Recursive[0].icon
data modify storage skill:selection Options[-1].label.with[0].atlas set from storage skill:registry Recursive[0].atlas
data modify storage skill:selection Options[-1].tooltip.translate set from storage skill:registry Recursive[0].desc
function skill:selection/set_command with storage skill:registry Recursive[0]

execute if score $config config.slots.runner_skill <= @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied run data modify storage skill:selection Options[-1].label.color set value "dark_gray"
execute if score $config config.slots.runner_skill <= @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied run data modify storage skill:selection Options[-1].label.with[0].color set value "dark_gray"
execute if score $config config.slots.runner_skill <= @s[tag=skill.selection.runner_skill] skill.slots.runner.occupied run data modify storage skill:selection Options[-1].label.strikethrough set value true
execute if score $config config.slots.killer_skill <= @s[tag=skill.selection.killer_skill] skill.slots.killer.occupied run data modify storage skill:selection Options[-1].label.color set value "dark_gray"
execute if score $config config.slots.killer_skill <= @s[tag=skill.selection.killer_skill] skill.slots.killer.occupied run data modify storage skill:selection Options[-1].label.with[0].color set value "dark_gray"
execute if score $config config.slots.killer_skill <= @s[tag=skill.selection.killer_skill] skill.slots.killer.occupied run data modify storage skill:selection Options[-1].label.strikethrough set value true
execute if score $config config.slots.weapon <= @s[tag=skill.selection.weapon] skill.slots.weapon.occupied run data modify storage skill:selection Options[-1].label.color set value "dark_gray"
execute if score $config config.slots.weapon <= @s[tag=skill.selection.weapon] skill.slots.weapon.occupied run data modify storage skill:selection Options[-1].label.with[0].color set value "dark_gray"
execute if score $config config.slots.weapon <= @s[tag=skill.selection.weapon] skill.slots.weapon.occupied run data modify storage skill:selection Options[-1].label.strikethrough set value true

# data merge storage skill:selection {"body": {"type": "minecraft:plain_message", "contents": []}}
function skill:selection/get_equipped with storage skill:registry Recursive[0]

data remove storage skill:registry Recursive[0]
execute if data storage skill:registry Recursive[0] run function skill:selection/make_options