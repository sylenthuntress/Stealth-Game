give @s amethyst_shard[
    custom_name={
        "color": "#861c8e",
        "translate": "skill.killer.specter.ability",
        "italic": false,
        "with": [
            {
                "sprite": "hide_and_squeak:item/specter",
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
        skill.killer.specter.ability: true
    },
    minecraft:item_model="hide_and_squeak:specter"
]