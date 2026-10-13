scoreboard players remove @s skill.runner.alchemist.count 1
scoreboard players set @s skill.runner.alchemist.cooldown 600
advancement revoke @s only skill:runner_skill/alchemist/throw_blinding_flask

item modify entity @s skill:runner_skill/alchemist/stagger_flask util:decrement

summon snowball ~ ~1 ~ {Tags:["skill.runner_skill.alchemist.blinding_flask"],Item:{id:"minecraft:coal",count:1,components:{"minecraft:item_model":"hide_and_squeak:blinding_flask"}}}
execute rotated as @s positioned 0.0 0.0 0.0 positioned ^ ^ ^1.5 summon area_effect_cloud run data modify entity @n[type=snowball,tag=skill.runner_skill.alchemist.blinding_flask] Motion set from entity @s Pos
data modify entity  @n[type=snowball,tag=skill.runner_skill.alchemist.blinding_flask] Owner set from entity @s UUID
summon marker ~ ~ ~ {Tags:["skill.runner_skill.alchemist.flask"]}
ride @n[type=marker,tag=skill.runner_skill.alchemist.flask] mount @n[type=snowball,tag=skill.runner_skill.alchemist.blinding_flask]

playsound minecraft:entity.snowball.throw player @s ~ ~ ~ 1 1
playsound minecraft:block.brewing_stand.brew player @s ~ ~ ~ 1 2