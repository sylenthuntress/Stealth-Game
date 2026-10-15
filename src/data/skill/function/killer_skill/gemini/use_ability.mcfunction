advancement revoke @s only skill:killer_skill/gemini/use_ability
item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:slime_ball","components":{"minecraft:custom_data":{"skill.killer.gemini.ability":true}}}} util:increment
item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:slime_ball","components":{"minecraft:custom_data":{"skill.killer.gemini.ability":true}}}} util:decrement

tag @s add this.self
execute as @e[type=mannequin,tag=skill.killer_skill.gemini.clone] if score @s uid.entity = @p[tag=this.self] uid.player run tag @s add this.selected

execute unless predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:effects":{"minecraft:invisibility":{}}}} scoreboard players set @s skill.killer.gemini.hide_teleport 3
effect give @s invisibility 1 1 true
effect give @n[tag=this.selected] invisibility 1 1 true
scoreboard players set @n[tag=this.selected] skill.killer.gemini.hide_teleport 3

execute if predicate util:is_sneaking run data merge entity @n[tag=this.selected] {pose:"crouching",CustomNameVisible:false}
execute unless predicate util:is_sneaking run data merge entity @n[tag=this.selected] {pose:"standing",CustomNameVisible:true}

summon marker ~ ~ ~ {Tags:["skill.killer_skill.gemini.anchor"]}
rotate @n[type=marker,tag=skill.killer_skill.gemini.anchor] ~ ~

tp @s @n[tag=this.selected]
tp @n[tag=this.selected] @n[type=marker,tag=skill.killer_skill.gemini.anchor]
kill @e[type=marker,tag=skill.killer_skill.gemini.anchor]

execute at @s[scores={skill.killer.gemini.hide_teleport=1..}] expand:
    function skill:killer_skill/gemini/spawn_mannequin with entity @s
    tag @n[type=mannequin,tag=!this.selected] add skill.killer_skill.gemini.display
execute at @n[tag=this.selected] expand:
    function skill:killer_skill/gemini/copy_mannequin with entity @n[tag=this.selected]
    tag @n[type=mannequin,tag=!this.selected] add skill.killer_skill.gemini.display

tag @a remove this.selected
tag @s remove this.self