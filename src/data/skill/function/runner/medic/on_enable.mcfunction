append function_tag skill:event/on_enable {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.medic] run return fail

scoreboard players set @s skill.runner.medic.count 2
scoreboard players set @s skill.runner.medic.uses 0