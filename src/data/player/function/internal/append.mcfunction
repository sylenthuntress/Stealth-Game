data modify storage player:data players append value {uid: 0, uuid: []}
data modify storage player:data players[-1].uuid set from entity @s UUID
execute store result storage player:data players[-1].uid int 1 run scoreboard players get @s uid