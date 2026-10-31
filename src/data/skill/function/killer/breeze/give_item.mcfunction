scoreboard players add @s skill.killer.breeze.count 1

execute unless slots entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:barrier","predicates":{"minecraft:custom_data":{"skill.killer.breeze.cooldown":true}}}} run return run give @s coal[
    custom_name={
        "color": "#84cacb",
        "translate": "skill.killer.breeze.ability",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:mob_effect/wind_charged",
                "atlas": "minecraft:gui",
                "color": "white"
            },
            [
                {
                    "translate": "skill.use",
                    "color": "#499ead"
                }
            ]
        ]
    },
    consumable={
        consume_seconds: 0.05,
        has_consume_particles: false,
        animation: "bow",
        sound:{sound_id:""}
    },
    max_stack_size=3,
    custom_data={
        skill.killer.breeze.ability: true,
        skill.killer.breeze.cooldown: false
    },
    item_model="minecraft:wind_charge"
]

item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:barrier","predicates":{"minecraft:custom_data":{"skill.killer.breeze.cooldown":true}}}} {
            "type": "minecraft:sequence",
            "functions": [
                {
                    "type": "minecraft:set_item",
                    "item": "minecraft:coal"
                },
                {
                    "type": "minecraft:set_components",
                    "components": {
                        "custom_name": {
                        "color": "#84cacb",
                        "translate": "skill.killer.breeze.ability",
                        "italic": false,
                        "with": [
                            {
                                "sprite": "minecraft:mob_effect/wind_charged",
                                "atlas": "minecraft:gui",
                                "color": "white"
                            }
                        ]
                        },
                        "consumable": {
                            "consume_seconds": 0.05,
                            "has_consume_particles": false,
                            "animation": "bow",
                            "sound": {
                                "sound_id": ""
                            }
                        },
                        "custom_data": {
                            "skill.killer.breeze.ability": true,
                            "skill.killer.breeze.cooldown": false
                        },
                        "item_model": "minecraft:wind_charge"
                    }
                }
            ]
        }
