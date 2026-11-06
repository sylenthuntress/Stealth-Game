append function_tag event:disable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.killer.athlete] run return fail

scoreboard players reset @s skill.killer.athlete.cooldown
function ./stop_dashing
item fill entity @s ./ability with air
item fill entity @s ./cooldown with air