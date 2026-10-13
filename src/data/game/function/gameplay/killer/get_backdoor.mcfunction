scoreboard players operation @s game.player.target_band = $gamestate gamestate.band_progression
execute if score @s game.player.target_band < $segments segments.elapsed run scoreboard players add @s game.player.target_band 1

execute unless slots entity @s game:backdoor expand:
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
execute if score $gamestate gamestate.band_progression matches 1.. run item modify entity @s game:backdoor game:backdoor