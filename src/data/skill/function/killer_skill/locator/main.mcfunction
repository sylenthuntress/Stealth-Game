execute unless score @s skill.killer.locator.cooldown matches 1.. unless score @s skill.killer.locator.tracking_timer matches 0.. function skill:killer_skill/locator/passive_tracking:
    scoreboard objectives add var.runners dummy
    execute store result score $var var.runners if entity @a[team=runner]
    execute if score $var var.runners matches ..1 run return run function skill:killer_skill/locator/fail_tracking:
        scoreboard objectives remove var.runners

    scoreboard players set @s skill.killer.locator.tracking_timer 1
    execute at @s run scoreboard players operation @s skill.killer.locator.tracking_uid = @p[distance=..32,sort=furthest,team=runner] uid.player

tag @s add this.self
execute as @a[team=runner] if score @s uid.player = @p[tag=this.self] skill.killer.locator.tracking_uid run data modify storage skill:data KillerSkills.Locator.Tracked.Pos set from entity @s Pos
tag @s remove this.self

function skill:killer_skill/locator/point_compass with storage skill:data KillerSkills.Locator.Tracked

execute function skill:killer_skill/locator/tick_tracking:
    scoreboard players remove @s skill.killer.locator.tracking_timer 1

    scoreboard players operation $display time.display_sec = @s skill.killer.locator.tracking_timer
    scoreboard players operation $display time.display_sec /= $20 math.const

    item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:compass","predicates":{"minecraft:custom_data":{"skill.killer.locator.locked":true}}}} {
        "type": "minecraft:set_name",
        "entity": "this",
        "name": [
            {
                "color": "#C68346",
                "translate": "skill.killer.locator.locked",
                "italic": false,
                "with": [
                    {
                        "sprite": "minecraft:item/compass_00",
                        "atlas": "minecraft:items",
                        "color": "white"
                    }
                ]
            },
            " ",
            {
                "color": "gold",
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
                        "color": "#b1a370"
                    }
                ]
            }
        ]
    }

    execute if score @s skill.killer.locator.tracking_timer matches ..0 function skill:killer_skill/locator/refresh_tracking:
        item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:compass","predicates":{"minecraft:custom_data":{"skill.killer.locator.ability":true}}}} {
            "type": "minecraft:set_components",
                "components": {
                    "custom_name": {
                        "color": "#C68346",
                        "translate": "skill.killer.locator.ability",
                        "italic": false,
                        "with": [
                            {
                                "sprite": "minecraft:item/compass_00",
                                "atlas": "minecraft:items",
                                "color": "white"
                            }
                        ]
                    },
                    "consumable": {
                        "consume_seconds": 0.05,
                        "has_consume_particles": false,
                        "animation": "bow",
                        "sound":{"sound_id":""}
                    },
                    "custom_data": {
                        "skill.killer.locator.ability": true,
                        "skill.killer.locator.locked": false
                    },
                    "enchantment_glint_override": false,
                    "minecraft:lodestone_tracker": {
                        "target": {
                            "pos": [0,0,0],
                            "dimension": "minecraft:the_nether"
                        }, 
                        "tracked": false
                    }
                }
            }
        scoreboard players reset @s skill.killer.locator.tracking_uid
        scoreboard players reset @s skill.killer.locator.tracking_timer

execute unless score @s skill.killer.locator.tracking_timer matches 0.. if score @s skill.killer.locator.cooldown matches 1.. run function skill:killer_skill/locator/tick_cooldown:
    scoreboard players remove @s skill.killer.locator.cooldown 1

    scoreboard players operation $display time.display_sec = @s skill.killer.locator.cooldown
    scoreboard players operation $display time.display_sec /= $20 math.const

    item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:compass","predicates":{"minecraft:custom_data":{"skill.killer.locator.ability":true}}}} {
            "type": "minecraft:sequence",
            "functions": [
                {
                    "type": "minecraft:set_name",
                    "entity": "this",
                    "name": [
                        {
                            "sprite": "minecraft:item/compass_00",
                            "atlas": "minecraft:items",
                            "color": "dark_gray"
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
                },
                {
                    "type": "minecraft:set_components",
                    "components": {
                        "!consumable": {},
                        "custom_data": {
                            "skill.killer.locator.ability": true,
                            "skill.killer.locator.locked": false,
                            "skill.killer.locator.cooldown": true
                        },
                        "enchantment_glint_override": false,
                        "minecraft:lodestone_tracker": {
                            "target": {
                                "pos": [0,0,0],
                                "dimension": "minecraft:the_nether"
                            }, 
                            "tracked": false
                        }
                    }
                }
            ]
        }
    execute if score @s skill.killer.locator.cooldown matches 0 run function skill:killer_skill/locator/end_cooldown:
        scoreboard players reset @s skill.killer.locator.cooldown
        item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:compass","predicates":{"minecraft:custom_data":{"skill.killer.locator.cooldown":true}}}} {
            "type": "minecraft:set_components",
                "components": {
                    "custom_name": {
                        "color": "#C68346",
                        "translate": "skill.killer.locator.ability",
                        "italic": false,
                        "with": [
                            {
                                "sprite": "minecraft:item/compass_00",
                                "atlas": "minecraft:items",
                                "color": "white"
                            }
                        ]
                    },
                    "consumable": {
                        "consume_seconds": 0.05,
                        "has_consume_particles": false,
                        "animation": "bow",
                        "sound":{"sound_id":""}
                    },
                    "custom_data": {
                        "skill.killer.locator.ability": true,
                        "skill.killer.locator.locked": false,
                        "skill.killer.locator.cooldown": false
                    }
                }
            }