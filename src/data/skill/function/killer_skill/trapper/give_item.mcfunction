give @s tripwire_hook[
    custom_name={
        "color": "#866654",
        "translate": "skill.killer.trapper.ability",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:block/tripwire_hook",
                "atlas": "minecraft:blocks",
                "color": "white"
            },
            [
                {
                    "translate": "skill.use",
                    "color": "#c46e3c"
                },
                {
                    "text": "/",
                    "color": "#c46e3c"
                },
                {
                    "translate": "skill.drop",
                    "color": "#c46e3c"
                }
            ]
        ]
    },
    consumable={
        consume_seconds: 0.05,
        has_consume_particles: false,
        animation: "bow",
        sound:{sound_id:""}
    },
    custom_data={
        skill.killer.trapper.ability: true
    }
]