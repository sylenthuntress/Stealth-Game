append function_tag skill:event/on_disable {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.weapon.foreseer] run return fail

# Cooldowns
scoreboard players reset @s skill.weapon.foreseer.cooldown