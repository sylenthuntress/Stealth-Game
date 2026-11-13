execute unless score @s time.player.recovery_timer matches 1.. function game:gameplay/killer/get_backdoor

# Manage attack recovery
execute if score @s time.player.recovery_timer matches 1.. run scoreboard players remove @s time.player.recovery_timer 1
execute if score @s time.player.recovery_timer matches 0 expand:
    attribute @s minecraft:movement_speed modifier remove game:gameplay/killer/recovery
    attribute @s minecraft:attack_speed modifier remove game:gameplay/killer/recovery
    attribute @s minecraft:attack_damage modifier remove game:gameplay/killer/recovery
    scoreboard players reset @s time.player.recovery_timer

## Manage invisibility
execute if entity @s[tag=!game.player.invisible] if predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:effects":{"minecraft:invisibility":{}}}} function ./../start_invisibility:
    item replace entity @s armor.head with air
    item replace entity @s armor.chest with air
    item replace entity @s armor.legs with air
    item replace entity @s armor.feet with air
    tag @s add game.player.invisible
execute  unless predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:effects":{"minecraft:invisibility":{}}}} function ./../end_invisibility:
    function cosmetic:add_equipment
    tag @s remove game.player.invisible