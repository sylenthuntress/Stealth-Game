$tag @s remove $(id)

data modify storage skill:selection selector.id set from storage skill:selection Recursive[0].id
function ./announcement/remove_name with storage skill:selection selector

data remove storage skill:selection Recursive[0]
execute if data storage skill:selection Recursive[0] run function skill:remove_tags with storage skill:selection Recursive[0]