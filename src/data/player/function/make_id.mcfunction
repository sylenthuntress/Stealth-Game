function ./internal/check_uuid with entity @s
scoreboard players operation #uid.index uid.index > @s uid
execute if score @s uid matches 1.. run return fail

execute store result score @s uid store result storage player:data players[-1].uid int 1 run scoreboard players add #uid.index uid.index 1