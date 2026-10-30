append function_tag skill:event/on_enable {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.killer.locator] run return fail

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
    },
    item_model="hide_and_squeak:pest_tracker"
]

# Scores
scoreboard players reset @s skill.killer.locator.cooldown
scoreboard players reset @s skill.killer.locator.tracking_timer
scoreboard players reset @s skill.killer.locator.tracking_uid