append function_tag skill:event/on_disable {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.brawler] run return fail

attribute @s minecraft:attack_knockback modifier remove skill:runner_skill/brawler
attribute @s minecraft:attack_damage modifier remove ./cooldown
attribute @s minecraft:attack_speed modifier remove ./cooldown
scoreboard players reset @s skill.runner.brawler.uses
scoreboard players reset @s skill.runner.brawler.cooldown