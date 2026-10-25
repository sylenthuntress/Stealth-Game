advancement ./use_ability: {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:consume_item",
            "conditions": {
                "item": {
                    "predicates": {
                        "minecraft:custom_data": "{skill.killer.specter.ability: true}"
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
scoreboard players set @s skill.killer.specter.cooldown 600

item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:amethyst_shard","predicates":{"minecraft:custom_data":{"skill.killer.specter.ability":true}}}} {
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
                "skill.killer.specter.cooldown": true
            },
            "minecraft:item_model": "hide_and_squeak:cooldown",
            "!minecraft:consumable": {}
            }
        }
    ]
}

particle witch ~ ~1 ~ 0.25 0.75 0.25 0.3 50 force
playsound minecraft:entity.vex.death player @a ~ ~ ~ 2 1 0.1
effect give @s invisibility 6 0 true