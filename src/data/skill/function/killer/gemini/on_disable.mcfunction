append function_tag event:disable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.killer.gemini] run return fail

tag @s add this.self
execute as @e[type=mannequin,tag=skill.killer.gemini.clone] if score @s uid.entity = @n[tag=this.self] uid.player run kill @s
tag @s remove this.self