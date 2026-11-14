append function_tag event:enable_skills {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.weapon.auto_crossbow] run return fail

give @s crossbow[
    custom_name={
        "color": "#706a49",
        "translate": "skill.weapon.auto_crossbow",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:item/crossbow_arrow",
                "atlas": "minecraft:items",
                "color": "white"
            }
        ]
    },
    unbreakable={},
    enchantment_glint_override=false,
    custom_data={
        "skill.weapon.auto_crossbow": true
    }
]

# Cooldowns
scoreboard players reset @s skill.weapon.auto_crossbow.cooldown
scoreboard players reset @s skill.weapon.auto_crossbow.count

# Arrows
function ./give_item
scoreboard players set @s skill.weapon.auto_crossbow.cooldown 100