item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:crossbow","predicates":{"minecraft:custom_data":{"skill.weapon.auto_crossbow":true}}}} {
  "type": "minecraft:set_components",
  "components": {
    "minecraft:charged_projectiles": [
      {
        "id": "minecraft:arrow"
      }
    ]
  }
}

scoreboard players add @s skill.weapon.auto_crossbow.count 1
execute if score @s skill.weapon.auto_crossbow.count matches ..1 run return 1

unless slots entity @s {type:"minecraft:filtered",slot_source:{type:"minecraft:slot_range",slots:"hotbar.8"},item_filter:{items:"minecraft:air"}} run give @s minecraft:arrow[
    custom_name={
        "color": "#706a49",
        "translate": "skill.weapon.auto_crossbow.arrow",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:item/crossbow_arrow",
                "atlas": "minecraft:items",
                "color": "white"
            }
        ]
    },
    custom_data={"skill.weapon.auto_crossbow.arrow": true}
]

if slots entity @s {type:"minecraft:filtered",slot_source:{type:"minecraft:slot_range",slots:"hotbar.8"},item_filter:{items:"minecraft:air"}} run item replace entity @s hotbar.8 with minecraft:arrow[
    custom_name={
        "color": "#706a49",
        "translate": "skill.weapon.auto_crossbow.arrow",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:item/crossbow_arrow",
                "atlas": "minecraft:items",
                "color": "white"
            }
        ]
    },
    custom_data={"skill.weapon.auto_crossbow.arrow": true}
]