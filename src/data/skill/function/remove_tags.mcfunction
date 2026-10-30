$tag @s remove $(id)

data modify storage skill:data Selection.selector.id set from storage skill:data Selection.Recursive[0].id
function ./announcement/remove_name with storage skill:data Selection.selector

data remove storage skill:data Selection.Recursive[0]
execute if data storage skill:data Selection.Recursive[0] run function skill:remove_tags with storage skill:data Selection.Recursive[0]