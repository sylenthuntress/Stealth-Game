execute store result storage skill:temp selector.selectedoption int 1 run scoreboard players get @s skill.selection

scoreboard players reset @s skill.selection
function player:get/skills # re-append relevant entry and then copy its elements

# Mess with elements to see if any numids match the selection
scoreboard objectives add var.list_size dummy
scoreboard objectives add var.list_success dummy
execute store result score #var var.list_size if data storage player:data selected.skills[]
execute store result score #var var.list_success run data modify storage player:data selected.skills[].numid set from storage skill:temp selector.selectedoption

execute if score #var var.list_success >= #var var.list_size run function ./enable_selection with storage skill:temp selector
execute if score #var var.list_success < #var var.list_size run function ./disable_selection with storage skill:temp selector

# Remove temp variables
scoreboard objectives remove var.list_size
scoreboard objectives remove var.list_success

function ./enable_selection:
    $data modify storage player:data players[-1].skills append from storage skill:data Registry[{"numid":$(selectedoption)}]

    function ./gui/refresh
    execute at @s run playsound minecraft:entity.item.pickup ui @s ~ ~ ~ 0.5 2

function ./disable_selection:
    $data remove storage player:data players[-1].skills[{"numid": $(selectedoption)}]

    function ./gui/refresh
    execute at @s run playsound minecraft:entity.item.pickup ui @s ~ ~ ~ 0.5 0.5