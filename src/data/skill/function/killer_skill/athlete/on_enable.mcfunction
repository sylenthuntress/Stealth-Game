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
        animation: "bow",
        sound:{sound_id:""}
    },
    custom_data={
        skill.killer.athlete.dash_item: true
    }
]