append function_tag event:cross_band {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.warper] run return fail
execute if score @s skill.runner.warper.warp_length matches 600.. run return fail

execute if slots entity @s ./ability run function ./charge_item:
    item modify entity @s ./ability {
        "type": "minecraft:set_count",
        "count": 3,
        "add": true
    }

    playsound minecraft:block.respawn_anchor.charge player @s ~ ~ ~ 1 2
    scoreboard players add @s skill.runner.warper.warp_length 60

execute unless slots entity @s ./ability run function ./give_item:
    give @s clock[
        custom_name={
            "color": "#b97ecd",
            "translate": "skill.runner.warper.ability",
            "italic": false,
            "with": [
                {
                    "sprite": "hide_and_squeak:item/warp",
                    "atlas": "minecraft:items",
                    "color": "white"
                },
                {
                    "translate": "skill.use",
                    "color": "#87479c"
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
    ] 2

    playsound minecraft:block.end_portal_frame.fill player @s ~ ~ ~ 1 0.5
    scoreboard players set @s skill.runner.warper.warp_length 40
