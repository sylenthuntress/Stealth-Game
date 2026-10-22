item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:coal","predicates":{"minecraft:custom_data":{"skill.killer.breeze.ability":true}}}} {
        "type": "minecraft:set_name",
        "entity": "this",
        "name": [
            {
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
            }
        ]
    }

execute if score @s skill.killer.breeze.cooldown matches 1.. unless score @s skill.killer.breeze.count matches 3.. run function ./tick_cooldown:
    scoreboard players remove @s skill.killer.breeze.cooldown 1
    execute if score @s skill.killer.breeze.cooldown matches 0 expand:
        function ./give_item
        scoreboard players set @s skill.killer.breeze.cooldown 300

    scoreboard players operation #display time.display_sec = @s skill.killer.breeze.cooldown
    scoreboard players operation #display time.display_sec /= #20 math.const

    item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:coal","predicates":{"minecraft:custom_data":{"skill.killer.breeze.ability":true}}}} {
        "type": "minecraft:set_name",
        "entity": "this",
        "name": [
            {
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
            " ",
            {
                "color": "dark_aqua",
                "bold": true,
                "italic": false,
                "translate": "skill.cooldown",
                "with": [
                    {
                        "score": {
                            "name": "#display",
                            "objective": "time.display_sec"
                        },
                        "bold": true,
                        "color": "#126270"
                    }
                ]
            }
        ]
    }

    item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:barrier","predicates":{"minecraft:custom_data":{"skill.killer.breeze.ability":true}}}} {
        "type": "minecraft:set_name",
        "entity": "this",
        "name": [
            {
                "sprite": "minecraft:mob_effect/wind_charged",
                "atlas": "minecraft:gui",
                "color": "white"
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
                            "name": "#display",
                            "objective": "time.display_sec"
                        },
                        "bold": true,
                        "color": "#9e9d9b"
                    }
                ]
            }
        ]
    }