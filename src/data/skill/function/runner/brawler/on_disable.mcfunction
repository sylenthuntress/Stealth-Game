append function_tag event:disable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.brawler] run return fail

attribute @s minecraft:attack_knockback modifier remove skill:runner/brawler
attribute @s minecraft:attack_damage modifier remove ./cooldown
attribute @s minecraft:attack_speed modifier remove ./cooldown
scoreboard players reset @s skill.runner.brawler.uses
scoreboard players reset @s skill.runner.brawler.cooldown