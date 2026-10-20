tag @s add this.self
execute as @e[tag=skill.killer.trapper.trap] if score @s uid.entity = @p[tag=this.self] uid.player run kill @s
execute as @e[tag=skill.killer.trapper.dropped] if score @s uid.entity = @p[tag=this.self] uid.player run kill @s
tag @s remove this.self

scoreboard players reset @s skill.killer.trapper.count
item fill entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:tripwire_hook","predicates":{"minecraft:custom_data":{"skill.killer.trapper.ability":true}}}} with air
