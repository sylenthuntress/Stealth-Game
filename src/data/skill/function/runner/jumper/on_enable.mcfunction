append function_tag event:enable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.jumper] run return fail

scoreboard players reset @s skill.runner.jumper.charge_cooldown
scoreboard players reset @s skill.runner.jumper.charge