advancement ~/ {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:consume_item",
            "conditions": {
                "item": {
                    "predicates": {
                        "minecraft:custom_data": "{skill.killer.breeze.ability: true}"
                    }
                }
            }
        }
    },
    "rewards": {
        "function": (~/)
    }
}

advancement revoke @s only ~/
scoreboard players remove @s skill.killer.breeze.count 1
execute anchored eyes run summon breeze_wind_charge ~ ~1.25 ~ {Tags:["skill.killer.breeze.wind_charge","this.projectile"]}
data modify entity @n[type=breeze_wind_charge,tag=this.projectile] Thrower set from entity @s UUID
execute rotated as @s positioned 0.0 0.0 0.0 positioned ^ ^0.2 ^3 summon area_effect_cloud run data modify entity @n[type=breeze_wind_charge,tag=this.projectile] Motion set from entity @s Pos
tag @n[tag=this.projectile] remove this.projectile

execute if score @s skill.killer.breeze.count matches 0 run item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:coal","predicates":{"minecraft:custom_data":{"skill.killer.breeze.ability":true}}}} {
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
                    "skill.killer.breeze.cooldown": true,
                    "skill.killer.breeze.ability": true
                },
                "minecraft:item_model": "hide_and_squeak:cooldown",
                "!minecraft:consumable": {}
            }
        }
    ]
}

item modify entity @s {type:"minecraft:limit_slots","slot_source":{"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:coal","predicates":{"minecraft:custom_data":{"skill.killer.breeze.ability":true}}}},limit:1} util:decrement