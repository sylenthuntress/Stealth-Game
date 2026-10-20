append function_tag items:process_special {
    "values": ["skill:runner_skill/puppeteer/process_item"]
}

execute unless items entity @s contents *[custom_data~{"skill.runner.puppeteer.ability": true}] run return fail

summon snowball ~ ~ ~ {Tags:["skill.runner_skill.puppeteer.puppet"],Item:{id:"minecraft:snowball","count":1,"components":{"minecraft:item_model":"minecraft:air"}}}
data modify entity @n[type=snowball,tag=skill.runner_skill.puppeteer.puppet] Motion set from entity @s Motion
data modify entity @n[type=snowball,tag=skill.runner_skill.puppeteer.puppet] Owner set from entity @s Owner

execute if entity @s[nbt={Item:{components:{"minecraft:custom_data":{"skill.runner.puppeteer.large_puppet": true}}}}] expand:
    summon marker ~ ~ ~ {Tags:["skill.runner_skill.puppeteer.large_puppet","skill.runner_skill.puppeteer.puppet"]}
    on origin run scoreboard players set @s skill.runner.puppeteer.cooldown 900
execute if entity @s[nbt={Item:{components:{"minecraft:custom_data":{"skill.runner.puppeteer.small_puppet": true}}}}] expand:
    summon marker ~ ~ ~ {Tags:["skill.runner_skill.puppeteer.small_puppet","skill.runner_skill.puppeteer.puppet"]}
    on origin run scoreboard players set @s skill.runner.puppeteer.cooldown 400

ride @n[type=marker,tag=skill.runner_skill.puppeteer.puppet] mount @n[type=snowball,tag=skill.runner_skill.puppeteer.puppet]

execute on origin expand:
    function skill:runner_skill/puppeteer/give_item
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