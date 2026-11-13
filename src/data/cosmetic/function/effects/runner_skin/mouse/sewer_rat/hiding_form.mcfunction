append function_tag cosmetic:effects/hiding_form {
    "values": [(~/)]
}

execute unless entity @s[tag=cosmetic.runner_skin.sewer_rat] run return fail

particle minecraft:block_crumble{block_state:"minecraft:white_wool"} ~ ~ ~ 0.2 0.5 0.2 1 10 normal @a
summon minecraft:item_display ~ ~ ~ {Tags:["hiding_form","this.summoned"], teleport_duration: 1, item: {components: {"minecraft:profile": {properties: [{name: "textures", value: "eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZjM3OWUwOTI1MjgxNzMxNGJkMGI2OTRmN2Q1M2I0OGFmMmM3ZmE4NDk5MTA5ODAyYTQxYmIyOTRkMmY5M2UzZSJ9fX0="}]}}, count: 1, id: "minecraft:player_head"}, item_display: "head", transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [1.0f, 1.0f, 1.0f], translation: [0.0f, 0.5f, 0.0f]}}
data modify entity @n[type=item_display,tag=hiding_form,tag=this.summoned] item set from storage cosmetic:data Registry[{id:cosmetic.runner_skin.sewer_rat}].components."cosmetic:effects/hiding_form"
execute as @n[type=item_display,tag=hiding_form,tag=this.summoned] expand:
    scoreboard players operation @s uid = @p uid
    rotate @s ~ 0
    tp ~ ~ ~
    team join runner @s
    tag @s remove this.summoned