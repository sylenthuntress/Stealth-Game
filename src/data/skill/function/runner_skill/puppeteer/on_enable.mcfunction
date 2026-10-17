give @s minecraft:copper_nugget[
    custom_name={
        "color": "#caa541",
        "translate": "skill.runner.puppeteer.large_puppet",
        "italic": false,
        "with": [
            {
                "sprite": "hide_and_squeak:item/small_puppet",
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
        skill.runner.puppeteer.ability: true,
        skill.runner.puppeteer.large_puppet: true
    },
    item_model="hide_and_squeak:large_puppet"
]

give @s minecraft:copper_nugget[
    custom_name={
        "color": "#caa541",
        "translate": "skill.runner.puppeteer.small_puppet",
        "italic": false,
        "with": [
            {
                "sprite": "hide_and_squeak:item/small_puppet",
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
        skill.runner.puppeteer.ability: true,
        skill.runner.puppeteer.small_puppet: true
    },
    item_model="hide_and_squeak:small_puppet"
]