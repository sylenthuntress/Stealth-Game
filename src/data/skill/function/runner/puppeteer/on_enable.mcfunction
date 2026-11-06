append function_tag event:enable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.puppeteer] run return fail

function ./give_item

# Scores
scoreboard players reset @s skill.runner.puppeteer.cooldown