append function_tag cosmetic:effects/hiding_form {
    "values": [(~/)]
}

execute unless entity @s[tag=cosmetic.runner_skin.cave_turkey] run return fail

particle minecraft:block_crumble{block_state:"minecraft:brown_wool"} ~ ~ ~ 0.2 0.5 0.2 1 10 normal @a
tag @s add this.self
execute as @e[type=item_display,tag=hiding_form] if score @s uid = @p[tag=this.self] uid run tag @s add this.display

function animation:cosmetic/runner_skin/cave_turkey/hiding_form/summon {args: {}}
execute as @n[type=item_display,tag=animation.cosmetic.runner_skin.cave_turkey.hiding_form.root] run function animation:cosmetic/runner_skin/cave_turkey/hiding_form/animations/idle/play
execute as @n[type=item_display,tag=animation.cosmetic.runner_skin.cave_turkey.hiding_form.root,tag=this.summoned] at @s expand:
    scoreboard players operation @s uid = @p uid
    rotate @s ~ 0
    team join runner @s
    execute on passengers run team join runner @s
    tag @s add hiding_form
    tag @s remove this.summoned