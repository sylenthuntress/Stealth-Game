append function_tag skill:event/on_enable {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.brawler] run return fail

attribute @s minecraft:attack_knockback modifier add skill:runner_skill/brawler 1 add_value

# Scores
scoreboard players reset @s skill.runner.brawler.uses
scoreboard players reset @s skill.runner.brawler.cooldown