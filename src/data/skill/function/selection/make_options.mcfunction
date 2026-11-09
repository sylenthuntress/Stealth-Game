# Add variables
scoreboard objectives add var.locked dummy

# Initialize button
data modify storage skill:data Selection.dialog.actions append value {"label": {"translate": "", with: [{"atlas": "", "sprite": "", "color": "white"}]}, "tooltip": {"translate": ""}, width: 100, action: {"type": "minecraft:run_command", "command": ""}}
data modify storage skill:data Selection.dialog.actions[-1].label.translate set from storage skill:data Selection.Recursive[0].id
data modify storage skill:data Selection.dialog.actions[-1].label.with[0].sprite set from storage skill:data Selection.Recursive[0].icon.sprite
data modify storage skill:data Selection.dialog.actions[-1].label.with[0].atlas set from storage skill:data Selection.Recursive[0].icon.atlas
data modify storage skill:data Selection.dialog.actions[-1].tooltip set from storage skill:data Selection.Recursive[0].desc
data modify storage skill:data Selection.dialog.actions[-1].action.command set from storage skill:data Selection.Recursive[0].trigger
execute store success storage skill:data Selection.dialog.actions[-1].random byte 1 run data get storage skill:data Selection.Recursive[0].components{"skill:random":true}
execute store success storage skill:data Selection.dialog.actions[-1].default byte 1 if data storage skill:data Selection.Recursive[0].components{"skill:default": true} 

# Check if option is equipped
data modify storage skill:data Selection.dialog.actions[-1].equipped set value false
execute if function ./check_equipped run function ./equip_option
function ./check_equipped:
    scoreboard objectives add var.list_size dummy
    scoreboard objectives add var.list_success dummy
    data modify storage player:data test.skills set value []
    data modify storage player:data test.skills append from storage player:data selected.skills[].id
    execute store result score #var var.list_size if data storage player:data test.skills[]
    execute store result score #var var.list_success run data modify storage player:data test.skills[] set from storage skill:data Selection.Recursive[0].id
    execute if score #var var.list_success < #var var.list_size run return 1

    return fail
scoreboard objectives remove var.list_size
scoreboard objectives remove var.list_success
function ./equip_option:
    data modify storage skill:data Selection.dialog.actions[-1].label.color set value "green"
    data modify storage skill:data Selection.dialog.actions[-1].label.with[0].color set value "white"
    data modify storage skill:data Selection.dialog.actions[-1].label.strikethrough set value false
    data modify storage skill:data Selection.dialog.actions[-1].equipped set value true

# Loop function if there are more options to be made
scoreboard objectives remove var.locked
data remove storage skill:data Selection.Recursive[0]
execute if data storage skill:data Selection.Recursive[0] run return run function ~/

# Lock skills once all slots have been used
execute if data storage skill:data Selection.dialog.actions[{equipped:true, random:true}] expand:
    data modify storage skill:data Selection.dialog.actions[{random:false}].equipped set value false
    function ./lock_options

scoreboard objectives add var.occupied_slots dummy
execute store result score @s var.occupied_slots if data storage skill:data Selection.dialog.actions[{equipped:true,default:false}]

execute if score @s[tag=skill.selection.runner] var.occupied_slots >= #config config.slots.runner run function ./lock_options
execute if score @s[tag=skill.selection.killer] var.occupied_slots >= #config config.slots.killer run function ./lock_options
execute if score @s[tag=skill.selection.weapon] var.occupied_slots >= #config config.slots.weapon run function ./lock_options
function ./lock_options:
    data modify storage skill:data Selection.dialog.actions[{equipped:false, random:false}].label.color set value "dark_gray"
    data modify storage skill:data Selection.dialog.actions[{equipped:false, random:false}].label.with[0].color set value "dark_gray"
    data modify storage skill:data Selection.dialog.actions[{equipped:false, random:false}].label.strikethrough set value true
    data modify storage skill:data Selection.dialog.actions[{equipped:false, random:false}].action.command set value "trigger skill.selection set -1" 
    data modify storage skill:data Selection.dialog.actions[{equipped:false, random:false}].locked set value true

scoreboard objectives remove var.occupied_slots