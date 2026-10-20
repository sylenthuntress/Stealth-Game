advancement ./use_ability {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:consume_item",
            "conditions": {
                "item": {
                    "predicates": {
                        "minecraft:custom_data": "{skill.killer.trapper.ability: true}"
                    }
                }
            }
        }
    },
    "rewards": {
        "function": (./use_ability)
    }
}

advancement revoke @s only ./use_ability
scoreboard players remove @s skill.killer.trapper.count 1
execute anchored eyes run summon item ~ ~1.25 ~ {Tags:["skill.killer.trapper.dropped","items.processed","this.self"],Item:{id:"minecraft:tripwire_hook",count:1,components:{custom_data:{skill.killer.trapper.ability: true}}}}
data modify entity @n[type=item,tag=this.self] PickupDelay set value 32767
data modify entity @n[type=item,tag=this.self] Age set value -32767
data modify entity @n[type=item,tag=this.self] Thrower set from entity @s UUID
execute rotated as @s positioned 0.0 0.0 0.0 positioned ^ ^ ^1 summon area_effect_cloud run data modify entity @n[type=item,tag=this.self] Motion set from entity @s Pos
tag @e remove this.self