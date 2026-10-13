playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1 2
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1 1
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1 0

scoreboard players remove @s skill.runner.warper.count 1
scoreboard players set @s skill.runner.warper.cooldown 600
advancement revoke @s only skill:runner_skill/warper/use_ability

tag @s add this.self
execute as @e[type=marker,tag=skill.runner.warper.warp_spot,scores={skill.runner.warper.warp_spot=100}] if score @s uid.entity = @a[tag=this.self,limit=1] uid.player run teleport @a[tag=this.self,limit=1] @s
tag @s remove this.self

playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 1000 1