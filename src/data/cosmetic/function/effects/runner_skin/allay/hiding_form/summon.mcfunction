append function_tag cosmetic:effects/hiding_form {
    "values": [(~/)]
}

execute unless entity @s[tag=cosmetic.runner_skin.allay] run return fail

tag @s add this.self
execute as @e[type=item_display,tag=hiding_form] if score @s uid.entity = @p[tag=this.self] uid.player run tag @s add this.display
execute if entity @e[tag=this.display] run return run function ~/refresh_hiding:
    execute as @n[type=item_display,tag=this.display] run function animation:cosmetic/runner_skin/allay/hiding_form/animations/idle/play
    tag @e remove this.display
    tag @s remove this.self

function animation:cosmetic/runner_skin/allay/hiding_form/summon {args: {}}
execute as @n[type=item_display,tag=animation.cosmetic.runner_skin.allay.hiding_form.root] run function animation:cosmetic/runner_skin/allay/hiding_form/animations/idle/play
execute as @n[type=item_display,tag=animation.cosmetic.runner_skin.allay.hiding_form.root,tag=this.summoned] at @s expand:
    scoreboard players operation @s uid.entity = @p uid.player
    rotate @s ~ 0
    tp ~ ~ ~
    team join runner @s
    tag @s add hiding_form
    tag @s remove this.summoned

function ./../set_variant