# function items:dropped/process_special:

data modify entity @s Owner set from entity @s Thrower
data modify entity @s PickupDelay set value 0
function items:dropped/pick_up:
    tag @s add var.self
    execute on origin run tp @e[type=item,tag=var.self] @s
    tag @s remove var.self

tag @s add items.processed