data remove storage cosmetic:temp selector
data modify storage cosmetic:temp Recursive set value []

execute store result storage cosmetic:temp selector.uid int 1 run scoreboard players get @s uid
function player:get/cosmetics
execute if entity @s[scores={game.player.team_id=1}] run data modify storage cosmetic:temp Recursive append from storage player:data selected.cosmetics[{"type": "cosmetic:runner/skin"}].components."cosmetic:equipment"[]
execute if entity @s[scores={game.player.team_id=2}] run data modify storage cosmetic:temp Recursive append from storage player:data selected.cosmetics[{"type": "cosmetic:killer/skin"}].components."cosmetic:equipment"[]

execute unless data storage cosmetic:temp Recursive[] run return fail # Return function if no selection is found

function ./set_item with storage cosmetic:temp Recursive[0]
function ./set_item:
    # Add tag if conditions pass
    $item replace entity @s player.crafting.1 with $(id) 1
    $item modify entity @s player.crafting.1 {type:"minecraft:set_components",components:$(components)}
    $item replace entity @s $(slot) from entity @s player.crafting.1
    item replace entity @s player.crafting.1 with air

    data remove storage cosmetic:temp Recursive[0]
    execute if data storage cosmetic:temp Recursive[0] run function ~/ with storage cosmetic:temp Recursive[0]