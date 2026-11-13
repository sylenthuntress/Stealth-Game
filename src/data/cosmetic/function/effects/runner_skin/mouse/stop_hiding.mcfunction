append function_tag cosmetic:effects/stop_hiding {
    "values": [(~/)]
}

execute unless function ./has_skin run return fail

execute as @e[tag=this.display] run function animation:cosmetic/runner_skin/allay/hiding_form/animations/hurt/play_exclusive

particle minecraft:block_crumble{block_state:"minecraft:white_wool"} ~ ~ ~ 0.2 0.5 0.2 1 10 normal @a
return fail