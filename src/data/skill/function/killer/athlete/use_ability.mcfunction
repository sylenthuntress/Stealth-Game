advancement ./use_ability: {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:consume_item",
            "conditions": {
                "item": {
                    "predicates": {
                        "minecraft:custom_data": "{skill.killer.athlete.ability: true}"
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
scoreboard players set @s skill.killer.athlete.cooldown 300
scoreboard players set @s skill.killer.athlete.dash_timer 40

item modify entity @s ./ability ./disable_ability 
item modify entity @s ./cooldown ./set_cooldown

playsound minecraft:entity.blaze.shoot player @a ~ ~ ~ 2 1 0.1