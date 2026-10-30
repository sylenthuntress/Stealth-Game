append function_tag skill:event/on_enable {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.killer.specter] run return fail

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

# Scores
scoreboard players reset @s skill.killer.specter.cooldown