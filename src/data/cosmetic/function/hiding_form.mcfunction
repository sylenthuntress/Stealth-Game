function player:get/cosmetics

execute if data storage player:data selected.cosmetics[{type:"cosmetic:runner/skin"}].components."cosmetic:hiding_form"{"type":"cosmetic:item"} run function ~/item
execute if data storage player:data selected.cosmetics[{type:"cosmetic:runner/skin"}].components."cosmetic:hiding_form"{"type":"cosmetic:entity"} 
    run function ~/entity with storage player:data selected.cosmetics[{type:"cosmetic:runner/skin"}].components."cosmetic:hiding_form"

function ~/item:
    summon minecraft:item_display ~ ~ ~ {Tags:["little_mouse","this.summoned"], teleport_duration: 1, item: {components: {"minecraft:profile": {properties: [{name: "textures", value: "eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZjM3OWUwOTI1MjgxNzMxNGJkMGI2OTRmN2Q1M2I0OGFmMmM3ZmE4NDk5MTA5ODAyYTQxYmIyOTRkMmY5M2UzZSJ9fX0="}]}}, count: 1, id: "minecraft:player_head"}, item_display: "head", transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [1.0f, 1.0f, 1.0f], translation: [0.0f, 0.5f, 0.0f]}}
    data modify entity @n[type=item_display,tag=little_mouse,tag=this.summoned] item set from storage player:data selected.cosmetics[{type:"cosmetic:runner/skin"}].components."cosmetic:hiding_form"
    execute as @n[type=item_display,tag=little_mouse,tag=this.summoned] expand:
        unless score @s uid.entity matches 0.. run scoreboard players operation @s uid.entity = @p uid.player
        rotate @s ~ 0
        tp ~ ~ ~
        team join runner @s
        tag @s remove this.summoned

function ~/entity:
    $summon $(entity_type) ~ ~ ~ $(nbt)
    execute as @n[tag=this.summoned] expand:
        unless score @s uid.entity matches 0.. run scoreboard players operation @s uid.entity = @p uid.player
        rotate @s ~ 0
        tp ~ ~ ~
        team join runner @s
        tag @s remove this.summoned