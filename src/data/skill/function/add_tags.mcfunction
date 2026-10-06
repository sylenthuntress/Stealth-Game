$tag @s add $(id)
data remove storage skill:selection Recursive[0]
execute if data storage skill:selection Recursive[0] run function skill:add_tags with storage skill:selection Recursive[0]