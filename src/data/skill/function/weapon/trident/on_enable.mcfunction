give @s trident[
    custom_name={
        "color": "#9DFFF5",
        "translate": "skill.weapon.trident",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:item/trident",
                "atlas": "minecraft:items",
                "color": "white"
            }
        ]
    },
    unbreakable={},
    enchantments={
        "loyalty": 4,
        "skill:weapon/trident/no_inaccuracy": 1
    },
    enchantment_glint_override=false,
    attribute_modifiers=[
        {
            id: "attack_damage",
            type: "attack_damage",
            amount: 3,
            operation: "add_value",
            slot: "mainhand",
            display:{
                type: "hidden"
            }
        }
    ],
    custom_data={
        "skill.weapon.trident": true
    }
]