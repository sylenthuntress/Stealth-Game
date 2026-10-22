$tag @s add $(id)

data modify storage skill:selection selector.id set from storage skill:selection Recursive[0].id
function ./announcement/remove_name with storage skill:selection selector

data modify storage skill:selection selector.desc set from storage skill:selection Recursive[0].desc
data modify storage skill:selection selector.icon set from storage skill:selection Recursive[0].icon
data modify storage skill:selection selector.atlas set from storage skill:selection Recursive[0].atlas

execute if data storage skill:selection Recursive[0].runner_skill run data modify storage skill:selection selector.registry set value "runner_skill"
execute if data storage skill:selection Recursive[0].killer_skill run data modify storage skill:selection selector.registry set value "killer_skill"
execute if data storage skill:selection Recursive[0].weapon run data modify storage skill:selection selector.registry set value "weapon"

function ./announcement/add_name with storage skill:selection selector

data remove storage skill:selection Recursive[0]
execute if data storage skill:selection Recursive[0] run function skill:add_tags with storage skill:selection Recursive[0]