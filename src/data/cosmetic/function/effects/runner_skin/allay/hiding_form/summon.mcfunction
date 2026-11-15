append function_tag cosmetic:effects/hiding_form {
    "values": [(~/)]
}

execute unless entity @s[tag=cosmetic.runner_skin.allay] run return fail

tag @s add this.self
execute as @e[type=item_display,tag=hiding_form] if score @s uid.hiding_form = @p[tag=this.self] uid.hiding_form run tag @s add this.display

function animation:cosmetic/runner_skin/allay/hiding_form/summon {args: {}}
execute as @n[type=item_display,tag=animation.cosmetic.runner_skin.allay.hiding_form.root] run function animation:cosmetic/runner_skin/allay/hiding_form/animations/idle/play
execute as @n[type=item_display,tag=animation.cosmetic.runner_skin.allay.hiding_form.root,tag=this.summoned] at @s expand:
    scoreboard players operation @s uid.hiding_form = @p uid.hiding_form
    rotate @s ~ 0
    team join runner @s
    execute on passengers run team join runner @s
    tag @s add hiding_form
    tag @s remove this.summoned

function ./../set_variant