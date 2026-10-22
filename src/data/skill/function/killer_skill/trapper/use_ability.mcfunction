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
execute anchored eyes run summon item ~ ~1.25 ~ {Tags:["skill.killer.trapper.dropped","items.processed","this.projectile"],Item:{id:"minecraft:tripwire_hook",count:1,components:{custom_data:{skill.killer.trapper.ability: true}}}}
data modify entity @n[type=item,tag=this.projectile] PickupDelay set value 32767
data modify entity @n[type=item,tag=this.projectile] Age set value -32767
data modify entity @n[type=item,tag=this.projectile] Thrower set from entity @s UUID
execute rotated as @s positioned 0.0 0.0 0.0 positioned ^ ^ ^1 summon area_effect_cloud run data modify entity @n[type=item,tag=this.projectile] Motion set from entity @s Pos
tag @n[tag=this.projectile] remove this.projectile