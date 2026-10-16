scoreboard players reset @s skill.runner.warper.count
item fill entity @s skill:runner_skill/warper/ability with air
item fill entity @s skill:runner_skill/warper/cooldown with air

tag @s add this.self
execute as @e[type=marker,tag=skill.runner.warper.warp_spot] if score @s uid.entity = @n[tag=this.self] uid.player run kill @s
tag @s remove this.self