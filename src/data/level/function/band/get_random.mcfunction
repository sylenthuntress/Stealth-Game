$loot spawn ~ ~ ~ loot {"type": "minecraft:generic","pools": [{"rolls": 1, "entries": $(BandEntries)}]}
data modify storage level:pool selectedBandId set from entity @e[dx=0,dy=0,dz=0,limit=1,type=item] Item.components."minecraft:custom_name"
kill @e[dx=0,dy=0,dz=0,limit=1,type=item]

function level:band/validate with storage level:pool