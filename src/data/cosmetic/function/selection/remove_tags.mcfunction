data remove storage cosmetic:data Selection.selector
execute store result storage cosmetic:data Selection.selector.uid int 1 run scoreboard players get @s uid

data modify storage cosmetic:data Selection.Recursive set from storage cosmetic:data Registry

function ./remove_tag with storage cosmetic:data Selection.Recursive[0]
function ./remove_tag:
    $tag @s remove $(id)

    data remove storage cosmetic:data Selection.Recursive[0]
    execute if data storage cosmetic:data Selection.Recursive[0] run function ~/ with storage cosmetic:data Selection.Recursive[0]