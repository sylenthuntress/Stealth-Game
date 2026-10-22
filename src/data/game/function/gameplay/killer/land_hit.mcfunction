scoreboard players add @s time.player.recovery_timer 54
attribute @s minecraft:movement_speed modifier add game:gameplay/killer/recovery -0.985 add_multiplied_base
attribute @s minecraft:jump_strength modifier add game:gameplay/killer/recovery -0.985 add_multiplied_base
attribute @s minecraft:attack_damage modifier add game:gameplay/killer/recovery -1 add_multiplied_base
attribute @s minecraft:attack_speed modifier add game:gameplay/killer/recovery -1 add_multiplied_base
item modify entity @s items:backdoor {
    "type": "minecraft:sequence",
    "functions": [
        {
            "type": "minecraft:set_components",
            "components": {
                "!consumable": {},
                "custom_data": {
                    "item.killer.backdoor": true
                }
            }
        },
        {
            "type": "minecraft:set_name",
            "entity": "this",
            "name": {
                "color": "dark_gray",
                "translate": "item.killer.backdoor.disabled",
                "italic": true
            }
        }
    ]
}
