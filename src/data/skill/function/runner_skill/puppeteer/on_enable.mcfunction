give @s minecraft:copper_nugget[
    custom_name={
        "color": "#caa541",
        "translate": "skill.runner.puppeteer.large_puppet",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:mob_effect/infested",
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
        skill.runner.puppeteer.ability: true,
        skill.runner.puppeteer.large_puppet: true
    }
]

give @s minecraft:copper_nugget[
    custom_name={
        "color": "#caa541",
        "translate": "skill.runner.puppeteer.small_puppet",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:mob_effect/infested",
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
        skill.runner.puppeteer.ability: true,
        skill.runner.puppeteer.small_puppet: true
    }
]