append function_tag event:disable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.camouflage] run return fail

function ./not_hiding