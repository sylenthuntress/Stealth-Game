import util:coordinates as coords

scoreboard players add @s lobby.credits.play_music 1
particle minecraft:witch coords.credits.x 32 coords.credits.z 0.3 0.5 0.3 1 1 normal @s
execute if score @s lobby.credits.play_music matches 30 run function ./play_music

execute if predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:effects":{"minecraft:darkness":{}}}} at @s expand:
    rotate @s facing entity @n[type=mannequin,tag=lobby.menu.credits.mannequin] eyes
    rotate @s ~ 0
    execute if score @s lobby.credits.play_music matches 550.. facing coords.credits.x 31 coords.credits.z run tp ^ ^ ^.03