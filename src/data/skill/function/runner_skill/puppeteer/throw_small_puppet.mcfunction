advancement ./throw_small_puppet: {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:consume_item",
            "conditions": {
                "item": {
                    "predicates": {
                        "minecraft:custom_data": "{skill.runner.puppeteer.small_puppet: true}"
                    }
                }
            }
        }
    },
    "rewards": {
        "function": (./throw_small_puppet)
    }
}

scoreboard players set @s skill.runner.puppeteer.cooldown 400
advancement revoke @s only ./throw_small_puppet

item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:player_head","predicates":{"minecraft:custom_data":{"skill.runner.puppeteer.large_puppet":true}}}} {
    "type": "minecraft:sequence",
    "functions": [
        {
            "type": "minecraft:set_item",
            "item": "minecraft:barrier"
        },
        {
            "type": "minecraft:set_components",
            "components": {
            "minecraft:custom_data": {
                "skill.runner.puppeteer.large_puppet": true,
                "skill.runner.puppeteer.cooldown": true
            },
            "minecraft:item_model": "hide_and_squeak:cooldown",
            "!minecraft:consumable": {}
            }
        }
    ]
}

item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:copper_nugget","predicates":{"minecraft:custom_data":{"skill.runner.puppeteer.small_puppet":true}}}} {
    "type": "minecraft:sequence",
    "functions": [
        {
            "type": "minecraft:set_item",
            "item": "minecraft:barrier"
        },
        {
            "type": "minecraft:set_components",
            "components": {
            "minecraft:custom_data": {
                "skill.runner.puppeteer.small_puppet": true,
                "skill.runner.puppeteer.cooldown": true
            },
            "minecraft:item_model": "hide_and_squeak:cooldown",
            "!minecraft:consumable": {}
            }
        }
    ]
}

summon snowball ~ ~1 ~ {Tags:["skill.runner_skill.puppeteer.puppet","this.projectile"],Item:{id:"minecraft:snowball","count":1,"components":{"minecraft:item_model":"minecraft:air"}}}
execute rotated as @s positioned 0.0 0.0 0.0 positioned ^ ^ ^1.5 summon area_effect_cloud run data modify entity @n[type=snowball,tag=this.projectile] Motion set from entity @s Pos
data modify entity  @n[type=snowball,tag=this.projectile] Owner set from entity @s UUID
summon marker ~ ~ ~ {Tags:["skill.runner_skill.puppeteer.small_puppet","skill.runner_skill.puppeteer.puppet"]}
ride @n[type=marker,tag=skill.runner_skill.puppeteer.small_puppet] mount @n[type=snowball,tag=this.projectile]

tag @n[tag=this.projectile] remove this.projectile

playsound minecraft:entity.snowball.throw player @s ~ ~ ~ 1 1
playsound minecraft:entity.armor_stand.place player @s ~ ~ ~ 2 1