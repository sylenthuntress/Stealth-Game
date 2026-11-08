data remove storage player:data selected
execute store result storage player:data selected.uid int 1 run scoreboard players get @s uid.player
execute if function ./../internal/check_tail run function ./../internal/reappend with storage player:data selected
data modify storage player:data selected.skills set from storage player:data players[-1].skills