scoreboard players reset @s skill.killer.specter.cooldown
function ./stop_cloaking
item fill entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:amethyst_shard","predicates":{"minecraft:custom_data":{"skill.killer.specter.ability":true}}}} with air
item fill entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:barrier","predicates":{"minecraft:custom_data":{"skill.killer.specter.cooldown":true}}}} with air