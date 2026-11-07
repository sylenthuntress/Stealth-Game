append function_tag event:enable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.jumper] run return fail

give @s golden_carrot[
    custom_name={
        "color": "#7ca132",
        "translate": "skill.runner.jumper.ability",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:mob_effect/jump_boost",
                "atlas": "minecraft:gui",
                "color": "white"
            },
            {
                "translate": "skill.use",
                "color": "#759953"
            }
        ]
    },
    consumable={
        consume_seconds: 2147483647,
        has_consume_particles: false,
        animation: "eat",
        sound:{sound_id:""}
    },
    food={
        nutrition:0,
        saturation:0,
        can_always_eat:true
    },
    custom_data={
        skill.runner.jumper.ability: true
    }
]

scoreboard players reset @s skill.runner.jumper.charge_cooldown
scoreboard players reset @s skill.runner.jumper.charge