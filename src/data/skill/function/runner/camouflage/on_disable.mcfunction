append function_tag skill:event/on_disable {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.camouflage] run return fail

function ./not_hiding