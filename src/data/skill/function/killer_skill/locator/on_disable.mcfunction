# Scores
scoreboard players reset @s skill.killer.locator.cooldown
scoreboard players reset @s skill.killer.locator.tracking_timer
scoreboard players reset @s skill.killer.locator.tracking_uid

item fill entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:compass","predicates":{"minecraft:custom_data":{"skill.killer.locator.ability":true}}}} with air