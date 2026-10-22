scoreboard players operation @s game.player.target_band = $gamestate gamestate.band_progression
scoreboard players add @s game.player.target_band 2

slot_source items:/backdoor {
    "type": "minecraft:filtered","slot_source": "util:inventory","item_filter": {"items": "minecraft:dark_oak_door","components": {"minecraft:custom_data": {"item.killer.backdoor": true}}}
}
execute unless slots entity @s game:gameplay/killer/backdoor expand:
    if slots entity @s {type:"minecraft:filtered",slot_source:{type:"minecraft:slot_range",slots:"hotbar.4"},item_filter:{items:"minecraft:air"}} run item replace entity @s hotbar.4 with minecraft:dark_oak_door[
        custom_name={
            "color": "dark_gray",
            "translate": "item.killer.backdoor.disabled",
            "italic": true
        },
        custom_data={"item.killer.backdoor": true}
    ]
    unless slots entity @s {type:"minecraft:filtered",slot_source:{type:"minecraft:slot_range",slots:"hotbar.4"},item_filter:{items:"minecraft:air"}} run give @s minecraft:dark_oak_door[
        custom_name={
            "color": "dark_gray",
            "translate": "item.killer.backdoor.disabled",
            "italic": true
        },
        custom_data={"item.killer.backdoor": true}
    ]
execute if score $gamestate gamestate.band_progression matches 2.. run item modify entity @s items:backdoor {
    "type": "minecraft:sequence",
    "functions": [
        {
            "type": "minecraft:set_components",
            "components": {
                "consumable": {
                    "consume_seconds": 0.05,
                    "has_consume_particles": false,
                    "animation": "bow",
                    "sound": {
                        "sound_id": ""
                    }
                },
                "custom_data": {
                    "item.killer.backdoor": true
                }
            }
        },
        {
            "type": "minecraft:set_name",
            "entity": "this",
            "name": {
                "translate": "item.killer.backdoor",
                "color": "red",
                "italic": false,
                "with": [
                    [
                        {
                            "translate": "item.killer.backdoor.band",
                            "color": "red"
                        },
                        " ",
                        {
                            "text": "#",
                            "color": "dark_red",
                            "bold": true,
                            "italic": false
                        },
                        {
                            "score": {
                                "objective": "game.player.target_band",
                                "name": "@s"
                            },
                            "bold": true,
                            "italic": false,
                            "color": "dark_red"
                        }
                    ]
                ]
            }
        }
    ]
}
execute if score @s game.player.target_band >= $segments segments.elapsed run item modify entity @s items:backdoor {
    "type": "minecraft:sequence",
    "functions": [
        {
            "type": "minecraft:set_components",
            "components": {
                "consumable": {
                    "consume_seconds": 0.05,
                    "has_consume_particles": false,
                    "animation": "bow",
                    "sound": {
                        "sound_id": ""
                    }
                },
                "custom_data": {
                    "item.killer.backdoor": true
                }
            }
        },
        {
            "type": "minecraft:set_name",
            "entity": "this",
            "name": {
                "translate": "item.killer.backdoor",
                "color": "red",
                "italic": false,
                "with": [
                    {
                        "translate": "item.killer.backdoor.finish_line",
                        "color": "gold",
                        "bold": true
                    }
                ]
            }
        }
    ]
}