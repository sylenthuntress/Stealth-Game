give @s bow[
    custom_name={
        "color": "#ffe02e",
        "translate": "skill.weapon.foreseer.spectral_bow",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:item/bow",
                "atlas": "minecraft:items",
                "color": "white"
            }
        ]
    },
    unbreakable={},
    enchantments={
      "skill:weapon/foreseer/no_inaccuracy": 1,
      "skill:weapon/foreseer/mark_projectile": 1,
      "skill:weapon/foreseer/infinity": 1
    },
    enchantment_glint_override=false,
    custom_data={
        "skill.weapon.foreseer.spectral_bow": true
    }
]

execute unless slots entity @s skill:weapon/foreseer/spectral_arrow expand:
    if slots entity @s {type:"minecraft:filtered",slot_source:{type:"minecraft:slot_range",slots:"hotbar.8"},item_filter:{items:"minecraft:air"}} run item replace entity @s hotbar.8 with minecraft:spectral_arrow[
        custom_name={
            "color": "#ffe02e",
            "translate": "skill.weapon.foreseer.spectral_arrow",
            "italic": false,
            "with": [
                {
                    "sprite": "minecraft:item/bow",
                    "atlas": "minecraft:items",
                    "color": "white"
                }
            ]
        },
        custom_data={"skill.weapon.foreseer.spectral_arrow": true}
    ]
    unless slots entity @s {type:"minecraft:filtered",slot_source:{type:"minecraft:slot_range",slots:"hotbar.8"},item_filter:{items:"minecraft:air"}} run give @s minecraft:spectral_arrow[
        custom_name={
            "color": "#ffe02e",
            "translate": "skill.weapon.foreseer.spectral_arrow",
            "italic": false,
            "with": [
                {
                    "sprite": "minecraft:item/bow",
                    "atlas": "minecraft:items",
                    "color": "white"
                }
            ]
        },
        custom_data={"skill.weapon.foreseer.spectral_arrow": true}
    ]
execute if score $gamestate gamestate.band_progression matches 1.. run item modify entity @s game:backdoor game:backdoor