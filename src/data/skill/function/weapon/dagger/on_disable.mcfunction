append function_tag event:disable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.weapon.dagger] run return fail

clear @s copper_sword