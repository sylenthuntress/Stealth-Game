give @s feather[
    custom_name={
        "color": "#9dfff5",
        "translate": "skill.killer.athlete.dash_item",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:mob_effect/speed",
                "atlas": "minecraft:gui",
                "color": "white"
            }
        ]
    },
    consumable={
        consume_seconds: 0.05,
        has_consume_particles: false,
        animation: "bow",
        sound:{sound_id:""}
    },
    custom_data={
        skill.killer.athlete.dash_item: true
    },
    minecraft:item_model="hide_and_squeak:dash"
]