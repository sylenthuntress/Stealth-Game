append function_tag event:disable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.killer.breeze] run return fail

scoreboard players reset @s skill.killer.breeze.cooldown
scoreboard players reset @s skill.killer.breeze.count
item fill entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:coal","predicates":{"minecraft:custom_data":{"skill.killer.breeze.ability":true}}}} with air