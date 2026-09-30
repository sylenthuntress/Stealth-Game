$loot spawn ~ ~ ~ loot {"type": "minecraft:generic","pools": [{"rolls": 1, "entries": $(Entries)}]}
data modify storage level:pool selectedId set from entity @e[dx=0,dy=0,dz=0,limit=1,type=item] Item.components."minecraft:custom_name"
kill @e[dx=0,dy=0,dz=0,limit=1,type=item]

function level:validate_segment with storage level:pool