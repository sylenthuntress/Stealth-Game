execute store result storage cosmetic:temp selector.selectedoption int 1 run scoreboard players get @s cosmetic.selection

scoreboard players reset @s cosmetic.selection
function player:get/cosmetics # re-append relevant entry and then copy its elements

# Mess with elements to see if any numids match the selection
scoreboard objectives add var.list_size dummy
scoreboard objectives add var.list_success dummy
execute store result score #var var.list_size if data storage player:data selected.cosmetics[]
execute store result score #var var.list_success run data modify storage player:data selected.cosmetics[].numid set from storage cosmetic:temp selector.selectedoption

execute if score #var var.list_success >= #var var.list_size run function ./enable_selection with storage cosmetic:temp selector
execute if score #var var.list_success < #var var.list_size run function ./disable_selection with storage cosmetic:temp selector

# Remove temp variables
scoreboard objectives remove var.list_size
scoreboard objectives remove var.list_success

function ./enable_selection:
    $data modify storage cosmetic:temp selector.selectedtype set from storage cosmetic:data Registry[{"numid":$(selectedoption)}].type
    function ./replace_selection with storage cosmetic:temp selector
    function ./replace_selection:
        $data remove storage player:data players[-1].cosmetics[{"type": "$(selectedtype)"}]

    $data modify storage player:data players[-1].cosmetics append from storage cosmetic:data Registry[{"numid":$(selectedoption)}]

    function ./gui/refresh
    execute at @s run playsound minecraft:entity.item.pickup ui @s ~ ~ ~ 0.5 2

function ./disable_selection:
    $execute if data storage cosmetic:data Registry[{"numid":$(selectedoption)}].components{"cosmetic:default": true} run return run function cosmetic:selection/fail_selection
    $data remove storage player:data players[-1].cosmetics[{"numid": $(selectedoption)}]

    function ./gui/refresh
    execute at @s run playsound minecraft:entity.item.pickup ui @s ~ ~ ~ 0.5 0.5