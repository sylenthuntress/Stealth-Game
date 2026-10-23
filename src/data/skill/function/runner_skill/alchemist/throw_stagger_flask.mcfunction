advancement ./throw_stagger_flask: {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:consume_item",
            "conditions": {
                "item": {
                    "predicates": {
                        "minecraft:custom_data": "{skill.runner.alchemist.stagger_flask: true}"
                    }
                }
            }
        }
    },
    "rewards": {
        "function": (./throw_stagger_flask)
    }
}

scoreboard players remove @s skill.runner.alchemist.count 1
scoreboard players set @s skill.runner.alchemist.cooldown 600
advancement revoke @s only ./throw_stagger_flask

item modify entity @s ./blinding_flask util:decrement

summon snowball ~ ~1 ~ {Tags:["skill.runner_skill.alchemist.stagger_flask","this.projectile"],Item:{id:"minecraft:coal",count:1,components:{"minecraft:item_model":"hide_and_squeak:stagger_flask"}}}
execute rotated as @s positioned 0.0 0.0 0.0 positioned ^ ^ ^1.5 summon area_effect_cloud store success entity @s Duration int 1 run data modify entity @n[type=snowball,tag=this.projectile] Motion set from entity @s Pos
data modify entity  @n[type=snowball,tag=this.projectile] Owner set from entity @s UUID
summon marker ~ ~ ~ {Tags:["skill.runner_skill.alchemist.flask"]}
ride @n[type=marker,tag=skill.runner_skill.alchemist.flask] mount @n[type=snowball,tag=this.projectile]

tag @n[tag=this.projectile] remove this.projectile

playsound minecraft:entity.snowball.throw player @s ~ ~ ~ 1 1
playsound minecraft:block.brewing_stand.brew player @s ~ ~ ~ 1 2