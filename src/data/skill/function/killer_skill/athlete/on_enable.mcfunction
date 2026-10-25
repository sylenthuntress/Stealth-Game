give @s feather[
    custom_name={
        "color": "#9dfff5",
        "translate": "skill.killer.athlete.ability",
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
        skill.killer.athlete.ability: true
    },
    minecraft:item_model="hide_and_squeak:dash"
]

# Scores
scoreboard players reset @s skill.killer.athlete.dash_timer