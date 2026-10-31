append function_tag items:process_special {
    "values": [(./process_item)]
}

execute unless items entity @s contents *[custom_data~{"skill.runner.puppeteer.ability": true}] run return fail

summon snowball ~ ~ ~ {Tags:["skill.runner.puppeteer.puppet"],Item:{id:"minecraft:snowball","count":1,"components":{"minecraft:item_model":"minecraft:air"}}}
data modify entity @n[type=snowball,tag=skill.runner.puppeteer.puppet] Motion set from entity @s Motion
data modify entity @n[type=snowball,tag=skill.runner.puppeteer.puppet] Owner set from entity @s Owner

execute if entity @s[nbt={Item:{components:{"minecraft:custom_data":{"skill.runner.puppeteer.large_puppet": true}}}}] expand:
    summon marker ~ ~ ~ {Tags:["skill.runner.puppeteer.large_puppet","skill.runner.puppeteer.puppet"]}
    on origin run scoreboard players set @s skill.runner.puppeteer.cooldown 900
execute if entity @s[nbt={Item:{components:{"minecraft:custom_data":{"skill.runner.puppeteer.small_puppet": true}}}}] expand:
    summon marker ~ ~ ~ {Tags:["skill.runner.puppeteer.small_puppet","skill.runner.puppeteer.puppet"]}
    on origin run scoreboard players set @s skill.runner.puppeteer.cooldown 400

ride @n[type=marker,tag=skill.runner.puppeteer.puppet] mount @n[type=snowball,tag=skill.runner.puppeteer.puppet]

execute on origin expand:
    function ./give_item
    item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:player_head","predicates":{"minecraft:custom_data":{"skill.runner.puppeteer.large_puppet":true}}}} {
        "type": "minecraft:sequence",
        "functions": [
            {
                "type": "minecraft:set_item",
                "item": "minecraft:barrier"
            },
            {
                "type": "minecraft:set_components",
                "components": {
                "minecraft:custom_data": {
                    "skill.runner.puppeteer.large_puppet": true,
                    "skill.runner.puppeteer.cooldown": true
                },
                "minecraft:item_model": "hide_and_squeak:cooldown",
                "!minecraft:consumable": {}
                }
            }
        ]
    }

    item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:copper_nugget","predicates":{"minecraft:custom_data":{"skill.runner.puppeteer.small_puppet":true}}}} {
        "type": "minecraft:sequence",
        "functions": [
            {
                "type": "minecraft:set_item",
                "item": "minecraft:barrier"
            },
            {
                "type": "minecraft:set_components",
                "components": {
                "minecraft:custom_data": {
                    "skill.runner.puppeteer.small_puppet": true,
                    "skill.runner.puppeteer.cooldown": true
                },
                "minecraft:item_model": "hide_and_squeak:cooldown",
                "!minecraft:consumable": {}
                }
            }
        ]
    }

kill @s