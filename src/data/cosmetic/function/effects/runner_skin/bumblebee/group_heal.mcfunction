append function_tag event:group_heal {
    "values": [(~/)]
}

execute unless entity @s[tag=cosmetic.runner_skin.bumblebee] run return fail

particle minecraft:heart ~ ~.5 ~ 0.75 0.2 0.75 0.6 3 normal @a
playsound minecraft:entity.bee.pollinate player @a ~ ~ ~ 0.1 0.7