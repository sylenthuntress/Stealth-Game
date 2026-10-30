append function_tag skill:event/on_disable {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.weapon.trident] run return fail

tag @s add this.selector
execute as @e[type=trident] run function skill:weapon/trident/kill_trident
tag @s remove this.selector

clear @s trident