append function_tag event:disable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.warper] run return fail

item fill entity @s ./ability with air

tag @s add this.self
execute as @e[type=marker,tag=skill.runner.warper.warp_spot] if score @s uid = @n[tag=this.self] uid run kill @s
tag @s remove this.self