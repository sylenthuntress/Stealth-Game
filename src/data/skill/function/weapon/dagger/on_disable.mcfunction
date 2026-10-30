append function_tag skill:event/on_disable {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.weapon.dagger] run return fail

clear @s copper_sword