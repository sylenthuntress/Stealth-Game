data remove storage player:data selected
data modify storage player:data selected.uuid set from entity @s UUID
execute if function ./../internal/check_tail run function ./../internal/reappend with storage player:data selected
data modify storage player:data selected.skills set from storage player:data players[-1].skills