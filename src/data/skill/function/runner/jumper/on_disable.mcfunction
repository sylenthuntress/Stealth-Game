append function_tag event:disable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.jumper] run return fail

scoreboard players reset @s skill.runner.jumper.charge_cooldown
scoreboard players reset @s skill.runner.jumper.charge
attribute @s minecraft:jump_strength modifier remove game:runner/jumper/charging
item fill entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:golden_carrot","predicates":{"minecraft:custom_data":{"skill.runner.jumper.ability":true}}}} with air
