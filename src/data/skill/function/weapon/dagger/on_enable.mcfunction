give @s copper_sword[
    custom_name={
        "color": "#C68346",
        "translate": "skill.weapon.dagger",
        "italic": false,
        "with": [
            {
                "sprite": "hide_and_squeak:item/dagger",
                "atlas": "minecraft:items",
                "color": "white"
            }
        ]
    },
    unbreakable={},
    item_model="hide_and_squeak:dagger",
    attribute_modifiers=[
        {
            id: "movement_speed",
            type: "movement_speed",
            amount: 0.2,
            operation: "add_multiplied_base",
            slot: "mainhand",
            display:{
                type: "hidden"
            }
        }
    ]
]