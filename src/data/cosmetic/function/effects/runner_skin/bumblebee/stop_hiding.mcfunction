append function_tag cosmetic:effects/stop_hiding {
    "values": [(~/)]
}

execute unless entity @s[tag=cosmetic.runner_skin.bumblebee] run return fail

particle minecraft:block_crumble{block_state:"minecraft:honey_block"} ~ ~ ~ 0.2 0.5 0.2 1 10 normal @a
return fail