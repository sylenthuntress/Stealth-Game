append function_tag event:enable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.weapon.dagger] run return fail

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
    custom_data={skill.weapon.dagger:true},
    unbreakable={},
    item_model="hide_and_squeak:dagger",
    attack_animation={
        type: "stab",
        duration: 10
    },
    attack_range={
        min_reach: 0.0,
        max_reach: 2,
        hitbox_margin: 0.2
    },
    minimum_attack_charge=1.0,
    attribute_modifiers=[
        {
            id: "movement_speed",
            type: "movement_speed",
            amount: 0.3,
            operation: "add_multiplied_base",
            slot: "mainhand",
            display:{
                type: "hidden"
            }
        }
    ]
]