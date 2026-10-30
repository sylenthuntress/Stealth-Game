function #skill:event/on_disable
data remove storage skill:data Selection.selector
execute store result storage skill:data Selection.selector.uid int 1 run scoreboard players get @s uid.player

data modify storage skill:data Selection.Recursive set from storage skill:data Registry

function skill:remove_tags with storage skill:data Selection.Recursive[0]
