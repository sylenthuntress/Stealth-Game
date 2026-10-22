# Prevent sprint jump exploit
execute unless predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:flags":{is_sprinting:1b}}} run return 1
scoreboard objectives add var.jump_strength dummy
execute store result score @s var.jump_strength run attribute @s minecraft:jump_strength get 100
teleport @s[scores={var.jump_strength=..0}] @s

scoreboard objectives remove var.jump_strength