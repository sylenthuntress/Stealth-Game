append function_tag skill:event/on_disable {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.warper] run return fail

scoreboard players reset @s skill.runner.warper.count
item fill entity @s ./ability with air
item fill entity @s ./cooldown with air

tag @s add this.self
execute as @e[type=marker,tag=skill.runner.warper.warp_spot] if score @s uid.entity = @n[tag=this.self] uid.player run kill @s
tag @s remove this.self