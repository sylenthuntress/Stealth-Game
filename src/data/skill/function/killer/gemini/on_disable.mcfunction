append function_tag event:disable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.killer.gemini] run return fail

tag @s add this.self
execute as @e[type=mannequin,tag=skill.killer.gemini.clone] if score @s uid.entity = @n[tag=this.self] uid.player run kill @s
tag @s remove this.self

item replace entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:slime_ball","predicates":{"minecraft:custom_data":{"skill.killer.gemini.ability":true}}}} with air