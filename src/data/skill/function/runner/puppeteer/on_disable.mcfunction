append function_tag event:disable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.puppeteer] run return fail

tag @s add this.self
execute as @e[tag=skill.runner.puppeteer.puppet] if score @s uid = @p[tag=this.self] uid run kill @s
execute as @e[tag=skill.runner.puppeteer.hiding_form] if score @s uid = @p[tag=this.self] uid on passengers run kill @s
execute as @e[tag=skill.runner.puppeteer.hiding_form] if score @s uid = @p[tag=this.self] uid run kill @s
tag @s remove this.self

item fill entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:barrier","predicates":{"minecraft:custom_data":{"skill.runner.puppeteer.cooldown":true}}}} with air
item fill entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":["minecraft:copper_nugget","minecraft:player_head"],"predicates":{"minecraft:custom_data":{"skill.runner.puppeteer.ability":true}}}} with air

# Scores
scoreboard players reset @s skill.runner.puppeteer.cooldown