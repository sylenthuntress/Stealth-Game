append function_tag event:enable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.warper] run return fail

# Scores
scoreboard players reset @s skill.runner.warper.count
scoreboard players reset @s skill.runner.warper.cooldown