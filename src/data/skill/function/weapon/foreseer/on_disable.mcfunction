append function_tag event:disable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.weapon.foreseer] run return fail

# Cooldowns
scoreboard players reset @s skill.weapon.foreseer.cooldown