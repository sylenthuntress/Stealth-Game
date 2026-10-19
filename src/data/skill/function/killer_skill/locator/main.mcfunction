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
                    "enchantment_glint_override": false
                }
            }
        scoreboard players reset @s skill.killer.locator.tracking_uid
        scoreboard players reset @s skill.killer.locator.tracking_timer

execute unless score @s skill.killer.locator.cooldown matches 1.. unless score @s skill.killer.locator.tracking_timer matches 0.. function skill:killer_skill/locator/passive_tracking:
    scoreboard objectives add var.runners dummy
    execute at @s store result score $var var.runners if entity @a[team=runner,distance=12..48]
    execute if score $var var.runners matches ..1 run return run function skill:killer_skill/locator/fail_tracking:
        scoreboard objectives remove var.runners

    scoreboard players set @s skill.killer.locator.tracking_timer 2
    execute at @s run scoreboard players operation @s skill.killer.locator.tracking_uid = @p[distance=12..48,sort=furthest,team=runner] uid.player
            item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:compass","predicates":{"minecraft:custom_data":{"skill.killer.locator.ability":true}}}} {
            "type": "minecraft:set_components",
                "components": {
                    "enchantment_glint_override": true
                }
            }

data modify storage skill:data KillerSkills.Locator.Tracked set value {pos:[0,0,0],dimension:the_nether}
tag @s add this.self
execute at @s as @a[team=runner] if score @s uid.player = @p[tag=this.self] skill.killer.locator.tracking_uid expand:
    data modify storage skill:data KillerSkills.Locator.Tracked.pos set from entity @s Pos
    data modify storage skill:data KillerSkills.Locator.Tracked.dimension set from entity @s Dimension
    if entity @s[distance=..12] as @p[tag=this.self] run function skill:killer_skill/locator/too_close:
        function skill:killer_skill/locator/refresh_tracking
        title @s actionbar {"color":"#9e3f3f","translate":"skill.killer.locator.too_close"}
        playsound minecraft:item.lodestone_compass.lock master @s ~ ~ ~ 1 0.2
        playsound minecraft:block.dispenser.fail master @s ~ ~ ~ 1
tag @s remove this.self

function skill:killer_skill/locator/point_compass with storage skill:data KillerSkills.Locator.Tracked

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