execute store result storage cosmetic:temp selector.selectedoption int 1 run scoreboard players get @s cosmetic.selection

execute function ./find_option:
    execute store result storage cosmetic:temp selector.uid int 1 run scoreboard players get @s uid.player
    function ./select_option with storage cosmetic:temp selector
function ./select_option:
    scoreboard players reset @s cosmetic.selection
    $execute unless data storage cosmetic:data Selection.players[{"uid": $(uid)}].cosmetics[{"numid": $(selectedoption)}] run return run function cosmetic:selection/enable_selection with storage cosmetic:temp selector
    $execute if data storage cosmetic:data Selection.players[{"uid": $(uid)}].cosmetics[{"numid": $(selectedoption)}] run return run function cosmetic:selection/disable_selection with storage cosmetic:temp selector

function ./enable_selection:
    $data modify storage cosmetic:temp selector.selectedtype set from storage cosmetic:data Registry[{"numid":$(selectedoption)}].type
    function ./replace_selection with storage cosmetic:temp selector
    function ./replace_selection:
        $data remove storage cosmetic:data Selection.players[{"uid": $(uid)}].cosmetics[{"type": "$(selectedtype)"}]


    $data modify storage cosmetic:data Selection.players[{"uid": $(uid)}].cosmetics append value {"id": "", "numid": 0, "type": ""}
    $data modify storage cosmetic:data Selection.players[{"uid": $(uid)}].cosmetics[-1].id set from storage cosmetic:data Registry[{"numid":$(selectedoption)}].id
    $data modify storage cosmetic:data Selection.players[{"uid": $(uid)}].cosmetics[-1].numid set from storage cosmetic:data Registry[{"numid":$(selectedoption)}].numid
    $data modify storage cosmetic:data Selection.players[{"uid": $(uid)}].cosmetics[-1].type set from storage cosmetic:data Registry[{"numid":$(selectedoption)}].type

    function ./gui/refresh
    execute at @s run playsound minecraft:entity.item.pickup ui @s ~ ~ ~ 0.5 2

function ./disable_selection:
    $execute if data storage cosmetic:data Registry[{"numid":$(selectedoption)}].components{"cosmetic:default": true} run return run function cosmetic:selection/fail_selection

    $data remove storage cosmetic:data Selection.players[{"uid": $(uid)}].cosmetics[{"numid": $(selectedoption)}]
    function ./gui/refresh
    execute at @s run playsound minecraft:entity.item.pickup ui @s ~ ~ ~ 0.5 0.5