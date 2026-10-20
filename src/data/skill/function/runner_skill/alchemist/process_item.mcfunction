append function_tag items:process_special {
    "values": ["skill:runner_skill/alchemist/process_item"]
}

execute unless items entity @s contents *[custom_data~{skill.runner.alchemist.ability: true}] run return fail

execute if items entity @s contents *[custom_data~{skill.runner.alchemist.blinding_flask: true}] expand:
    summon snowball ~ ~ ~ {Tags:["skill.runner_skill.alchemist.blinding_flask","skill.runner_skill.alchemist.flask"],Item:{id:"minecraft:coal",count:1,components:{"minecraft:item_model":"hide_and_squeak:blinding_flask"}}}
    on origin run item modify entity @s skill:runner_skill/alchemist/stagger_flask util:decrement
execute if items entity @s contents *[custom_data~{skill.runner.alchemist.stagger_flask: true}] expand:
    summon snowball ~ ~ ~ {Tags:["skill.runner_skill.alchemist.stagger_flask","skill.runner_skill.alchemist.flask"],Item:{id:"minecraft:coal",count:1,components:{"minecraft:item_model":"hide_and_squeak:stagger_flask"}}}
    on origin run item modify entity @s skill:runner_skill/alchemist/blinding_flask util:decrement

data modify entity @n[type=snowball,tag=skill.runner_skill.alchemist.flask] Motion set from entity @s Motion
data modify entity @n[type=snowball,tag=skill.runner_skill.alchemist.flask] Owner set from entity @s Thrower
    
summon marker ~ ~ ~ {Tags:["skill.runner_skill.alchemist.flask"]}
ride @n[type=marker,tag=skill.runner_skill.alchemist.flask] mount @n[type=snowball,tag=skill.runner_skill.alchemist.flask]

execute on origin expand:
    scoreboard players set @s skill.runner.alchemist.cooldown 600
    playsound minecraft:entity.snowball.throw player @s ~ ~ ~ 1 1
    playsound minecraft:block.brewing_stand.brew player @s ~ ~ ~ 1 2

kill @s