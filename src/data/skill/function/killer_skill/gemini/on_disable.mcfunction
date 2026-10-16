tag @s add this.self
execute as @e[type=mannequin,tag=skill.killer_skill.gemini.clone] if score @s uid.entity = @n[tag=this.self] uid.player run kill @s
tag @s remove this.self