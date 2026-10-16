execute if score @s skill.killer.specter.cooldown matches 1.. run function skill:killer_skill/specter/tick_cooldown:
    scoreboard players remove @s skill.killer.specter.cooldown 1

    scoreboard players operation $display time.display_sec = @s skill.killer.specter.cooldown
    scoreboard players operation $display time.display_sec /= $20 math.const

    item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:barrier","predicates":{"minecraft:custom_data":{"skill.killer.specter.cooldown":true}}}} {
            "type": "minecraft:set_name",
            "entity": "this",
            "name": [
                {
                    "color": "dark_gray",
                    "sprite": "hide_and_squeak:item/specter",
                    "atlas": "minecraft:items"
                },
                " ",
                {
                    "color": "dark_gray",
                    "bold": true,
                    "italic": false,
                    "translate": "skill.cooldown",
                    "with": [
                        {
                            "score": {
                                "name": "$display",
                                "objective": "time.display_sec"
                            },
                            "bold": true,
                            "color": "#9e9d9b"
                        }
                    ]
                }
            ]
        }

    execute if score @s skill.killer.specter.cooldown matches 0 run function skill:killer_skill/specter/end_cooldown:
        scoreboard players reset @s skill.killer.specter.cooldown
        item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:barrier","predicates":{"minecraft:custom_data":{"skill.killer.specter.cooldown":true}}}} {
            "type": "minecraft:sequence",
            "functions": [
                {
                    "type": "minecraft:set_item",
                    "item": "minecraft:amethyst_shard"
                },
                {
                    "type": "minecraft:set_components",
                    "components": {
                        "custom_name": {
                        "color": "#861c8e",
                        "translate": "skill.killer.specter.ability",
                        "italic": false,
                        "with": [
                            {
                                "sprite": "hide_and_squeak:item/specter",
                                "atlas": "minecraft:items",
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
                            "skill.killer.specter.ability": true,
                            "skill.killer.specter.cooldown": false
                        },
                        "item_model": "hide_and_squeak:specter"
                    }
                }
            ]
        }