# Add variables
scoreboard objectives add var.locked dummy

# Initialize button
data modify storage skill:data Selection.dialog.actions append value {"label": {"translate": "", with: [{"atlas": "", "sprite": "", "color": "white"}]}, "tooltip": {"translate": ""}, width: 100, action: {"type": "minecraft:run_command", "command": ""}}
data modify storage skill:data Selection.dialog.actions[-1].label.translate set from storage skill:data Selection.Recursive[0].id
data modify storage skill:data Selection.dialog.actions[-1].label.with[0].sprite set from storage skill:data Selection.Recursive[0].icon.sprite
data modify storage skill:data Selection.dialog.actions[-1].label.with[0].atlas set from storage skill:data Selection.Recursive[0].icon.atlas
data modify storage skill:data Selection.dialog.actions[-1].tooltip set from storage skill:data Selection.Recursive[0].desc

# Set on-click behavior
execute store result storage skill:data Selection.Recursive[0].uid int 1 run scoreboard players get @s uid.player 
function ./set_command with storage skill:data Selection.Recursive[0]
function ./set_command:
    $data modify storage skill:data Selection.dialog.actions[-1].action.command set value "trigger skill.selection set $(numid)" 

# Check if option is locked or equipped
function ./check_locked

execute unless score #var var.locked matches 1 run function ./check_equipped with storage skill:data Selection.Recursive[0]
function ./check_equipped:
    $execute if data storage skill:data Selection.players[{"uid": $(uid)}].skills[{"id": "$(id)"}] run return run function skill:selection/make_equipped_option
    function skill:selection/make_equipped_option:
        data modify storage skill:data Selection.dialog.actions[-1].label.color set value "green"
        data modify storage skill:data Selection.dialog.actions[-1].label.with[0].color set value "white"
        data modify storage skill:data Selection.dialog.actions[-1].label.strikethrough set value false
        data modify storage skill:data Selection.dialog.actions[-1].equipped set value true
    data modify storage skill:data Selection.dialog.actions[-1].equipped set value false

# Loop function if there are more options to be made
scoreboard objectives remove var.locked
data remove storage skill:data Selection.Recursive[0]
execute if data storage skill:data Selection.Recursive[0] run return run function ~/

# Lock skills once all slots have been used
scoreboard objectives add var.occupied_slots dummy
execute store result score @s var.occupied_slots if data storage skill:data Selection.dialog.actions[{equipped:true}]

execute if score @s[tag=skill.selection.runner_skill] var.occupied_slots >= #config config.slots.runner_skill run function ./lock_options
execute if score @s[tag=skill.selection.killer_skill] var.occupied_slots >= #config config.slots.killer_skill run function ./lock_options
execute if score @s[tag=skill.selection.weapon] var.occupied_slots >= #config config.slots.weapon run function ./lock_options
function ./lock_options:
    data modify storage skill:data Selection.dialog.actions[{equipped:false}].label.color set value "dark_gray"
    data modify storage skill:data Selection.dialog.actions[{equipped:false}].label.with[0].color set value "dark_gray"
    data modify storage skill:data Selection.dialog.actions[{equipped:false}].label.strikethrough set value true
    data modify storage skill:data Selection.dialog.actions[{equipped:false}].action.command set value "trigger skill.selection set -1" 
    data modify storage skill:data Selection.dialog.actions[{equipped:false}].locked set value true

scoreboard objectives remove var.occupied_slots