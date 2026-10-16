give @s compass[
    custom_name={
        "color": "#C68346",
        "translate": "skill.killer.locator.ability",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:item/compass_00",
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
        skill.killer.locator.ability: true,
        skill.killer.locator.locked: false
    },
    enchantment_glint_override=false,
    lodestone_tracker={
        target: {
            pos: [0,0,0],
            dimension: "minecraft:the_nether"
        }, 
        tracked: false
    }
]