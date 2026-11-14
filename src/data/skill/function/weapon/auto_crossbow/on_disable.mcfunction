append function_tag event:disable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.weapon.auto_crossbow] run return fail

# Cooldowns
scoreboard players reset @s skill.weapon.auto_crossbow.cooldown
scoreboard players reset @s skill.weapon.auto_crossbow.count