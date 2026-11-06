append function_tag event:enable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.alchemist] run return fail

# Scores
scoreboard players reset @s skill.runner.alchemist.cooldown
scoreboard players reset @s skill.runner.alchemist.count

# Items
for i in range(3):
    function ./give_item