tag @s add hiding
particle minecraft:block_crumble{block_state:"minecraft:white_wool"} ~ ~ ~ 0.2 0.5 0.2 1 10 normal @a
effect give @s invisibility infinite 0 true
attribute @s minecraft:camera_distance modifier add game:gameplay/runner/hiding 1.5 add_multiplied_base
attribute @s minecraft:attack_damage modifier add game:gameplay/runner/hiding -1 add_multiplied_base
attribute @s minecraft:sneaking_speed modifier add game:gameplay/runner/hiding 0.7 add_value
attribute @s minecraft:jump_strength modifier add game:gameplay/runner/hiding -0.1 add_value
attribute @s minecraft:gravity modifier add game:gameplay/runner/hiding 0.02 add_value
attribute @s minecraft:step_height modifier add game:gameplay/runner/hiding -0.3 add_value

summon minecraft:item_display ~ ~ ~ {Tags:["little_mouse","summoned"], teleport_duration: 1, item: {components: {"minecraft:profile": {properties: [{name: "textures", value: "eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZjM3OWUwOTI1MjgxNzMxNGJkMGI2OTRmN2Q1M2I0OGFmMmM3ZmE4NDk5MTA5ODAyYTQxYmIyOTRkMmY5M2UzZSJ9fX0="}]}}, count: 1, id: "minecraft:player_head"}, item_display: "head"}
data modify entity @n[type=item_display,tag=little_mouse,tag=summoned] item set from entity @s equipment.body
execute as @n[type=item_display,tag=little_mouse,tag=summoned] expand:
    unless score @s uid.entity matches 0.. run scoreboard players operation @s uid.entity = @p uid.player
    rotate @s ~180 0
    tp ~ ~0.55 ~
    team join runner @s
    tag @s remove summoned