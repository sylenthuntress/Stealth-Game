append function_tag skill:event/on_disable {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.jumper] run return fail

scoreboard players reset @s skill.runner.jumper.charge_cooldown
scoreboard players reset @s skill.runner.jumper.charge