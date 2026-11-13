append function_tag cosmetic:effects/stop_hiding {
    "values": [(~/)]
}

execute unless entity @s[tag=cosmetic.runner_skin.allay] run return fail

execute if data storage event:data context.stop_hiding{reason:"damage"} run return run function ./hurt:
    execute as @e[tag=this.display] function animation:cosmetic/runner_skin/allay/hiding_form/animations/hurt/play
    tag @e remove this.display
    return 1

execute as @e[tag=this.display] at @s run function ./despawn
tag @e remove this.display

return 1
function ./despawn: # This function runs as the allay as it despawns
    tag @s add this.self
    execute as @a[tag=!hiding] if score @s uid.player = @n[tag=this.self] uid.entity run tag @s add this.owner
    execute unless entity @a[tag=this.owner] run return run function ./cancel_despawn:
        function animation:cosmetic/runner_skin/allay/hiding_form/animations/idle/resume
        tag @s remove this.self

    execute as @a[tag=this.owner] at @s expand:
        function cosmetic:add_equipment
        function ./../set_variant

    tag @a remove this.owner
    tag @s remove this.self
    function animation:cosmetic/runner_skin/allay/hiding_form/remove/this