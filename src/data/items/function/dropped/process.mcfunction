execute function items:dropped/process_special:
    kill @s[nbt={Item:{components:{"minecraft:custom_data":{"item.killer.backdoor": true}}}}]
    function #items:process_special

execute if entity @s[tag=!items.nopickup] run function items:dropped/pick_up:
    data modify entity @s Owner set from entity @s Thrower
    data modify entity @s PickupDelay set value 0
    tag @s add var.self
    execute on origin run tp @e[type=item,tag=var.self] @s
    tag @s remove var.self

tag @s add items.processed