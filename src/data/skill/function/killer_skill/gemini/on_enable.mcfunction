function ./spawn_mannequin with entity @s

give @s slime_ball[
    custom_name={
        "color": "#7bd587",
        "translate": "skill.killer.gemini.ability",
        "italic": false,
        "with": [
            {
                "sprite": "hide_and_squeak:item/swap_bodies",
                "atlas": "minecraft:items",
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
        skill.killer.gemini.ability: true
    },
    item_model="hide_and_squeak:swap_bodies"
]