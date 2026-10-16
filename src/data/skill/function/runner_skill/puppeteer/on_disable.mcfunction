tag @s add this.self
execute as @e[tag=skill.runner_skill.puppeteer.puppet] if score @s uid.entity = @p[tag=this.self] uid.player run kill @s
execute as @e[tag=skill.runner_skill.puppeteer.little_mouse] if score @s uid.entity = @p[tag=this.self] uid.player run kill @s
tag @s remove this.self

item fill entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:barrier","predicates":{"minecraft:custom_data":{"skill.runner.puppeteer.cooldown":true}}}} with air
item fill entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:copper_nugget","predicates":{"minecraft:custom_data":{"skill.runner.puppeteer.ability":true}}}} with air