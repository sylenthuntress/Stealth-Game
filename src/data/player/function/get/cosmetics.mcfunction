data remove storage player:data selected
data modify storage player:data selected.uuid set from entity @s UUID
execute if function ./../internal/check_tail run function ./../internal/reappend with storage player:data selected
data modify storage player:data selected.cosmetics set from storage player:data players[-1].cosmetics

execute unless data storage player:data selected.cosmetics[{type:"cosmetic:runner/skin"}] 
    run data modify storage player:data selected.cosmetics prepend from storage cosmetic:data Registry[{type:"cosmetic:runner/skin",components:{"cosmetic:default":true}}]

execute unless data storage player:data selected.cosmetics[{type:"cosmetic:killer/skin"}] 
    run data modify storage player:data selected.cosmetics prepend from storage cosmetic:data Registry[{type:"cosmetic:killer/skin",components:{"cosmetic:default":true}}]