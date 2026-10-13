scoreboard players add @s skill.runner.alchemist.count 1
item modify entity @s {type:"minecraft:group",terms:{type:"minecraft:limit_slots",slot_source:"skill:runner_skill/alchemist/blinding_flask",limit:1}} util:increment
item modify entity @s {type:"minecraft:group",terms:{type:"minecraft:limit_slots",slot_source:"skill:runner_skill/alchemist/blinding_flask_cooldown",limit:1}} util:increment
item modify entity @s {type:"minecraft:group",terms:{type:"minecraft:limit_slots",slot_source:"skill:runner_skill/alchemist/stagger_flask",limit:1}} util:increment
item modify entity @s {type:"minecraft:group",terms:{type:"minecraft:limit_slots",slot_source:"skill:runner_skill/alchemist/stagger_flask_cooldown",limit:1}} util:increment
execute unless slots entity @s skill:runner_skill/alchemist/blinding_flask unless slots entity @s skill:runner_skill/alchemist/blinding_flask_cooldown run give @s coal[
    custom_name={
        "color": "#4b414e",
        "translate": "skill.runner.alchemist.blinding_flask",
        "italic": false,
        "with": [
            {
                "sprite": "hide_and_squeak:item/alchemist",
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
        skill.runner.alchemist.blinding_flask: true
    },
    minecraft:item_model="hide_and_squeak:blinding_flask"
]

execute unless slots entity @s skill:runner_skill/alchemist/stagger_flask unless slots entity @s skill:runner_skill/alchemist/stagger_flask_cooldown run give @s coal[
    custom_name={
        "color": "#933f2e",
        "translate": "skill.runner.alchemist.stagger_flask",
        "italic": false,
        "with": [
            {
                "sprite": "hide_and_squeak:item/alchemist",
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
        skill.runner.alchemist.stagger_flask: true
    },
    minecraft:item_model="hide_and_squeak:stagger_flask"
]

execute if score @s skill.runner.alchemist.cooldown matches 1.. run item modify entity @s skill:runner_skill/alchemist/blinding_flask skill:runner_skill/alchemist/disable_blinding_flask
execute if score @s skill.runner.alchemist.cooldown matches 1.. run item modify entity @s skill:runner_skill/alchemist/stagger_flask skill:runner_skill/alchemist/disable_stagger_flask
execute if score @s skill.runner.alchemist.cooldown matches 1.. run item modify entity @s skill:runner_skill/alchemist/blinding_flask_cooldown skill:runner_skill/alchemist/set_cooldown
execute if score @s skill.runner.alchemist.cooldown matches 1.. run item modify entity @s skill:runner_skill/alchemist/stagger_flask_cooldown skill:runner_skill/alchemist/set_cooldown