scoreboard players add @s skill.runner.warper.count 1
item modify entity @s {type:"minecraft:group",terms:{type:"minecraft:limit_slots",slot_source:"skill:runner_skill/warper/ability",limit:1}} util:increment
item modify entity @s {type:"minecraft:group",terms:{type:"minecraft:limit_slots",slot_source:"skill:runner_skill/warper/cooldown",limit:1}} util:increment
execute unless slots entity @s skill:runner_skill/warper/ability unless slots entity @s skill:runner_skill/warper/cooldown run give @s clock[
    custom_name={
        "color": "#b97ecd",
        "translate": "skill.runner.warper.ability",
        "italic": false,
        "with": [
            {
                "sprite": "hide_and_squeak:item/warp",
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
        skill.runner.warper.ability: true
    },
    minecraft:item_model="hide_and_squeak:warp"
]

execute if score @s skill.runner.warper.cooldown matches 1.. run item modify entity @s skill:runner_skill/warper/ability skill:runner_skill/warper/disable_ability
execute if score @s skill.runner.warper.cooldown matches 1.. run item modify entity @s skill:runner_skill/warper/cooldown skill:runner_skill/warper/set_cooldown

playsound minecraft:block.end_portal_frame.fill player @s ~ ~ ~ 1 0.5