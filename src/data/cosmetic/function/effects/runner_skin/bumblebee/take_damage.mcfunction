append function_tag cosmetic:effects/take_damage {
    "values": [(~/)]
}

execute unless entity @s[tag=cosmetic.runner_skin.bumblebee] run return fail

playsound minecraft:entity.bee.hurt player @a[tag=game.viewing] ~ ~ ~ 0.5 2
particle minecraft:falling_honey ~ ~ ~ 0.2 0.6 0.2 10 10 normal
scoreboard players add @s cosmetic.runner_skin.bumblebee.hurt_timer 100
function ./tick_anger:
    advancement ~/ {
        "criteria": {
            "requirement": {
                "trigger": "minecraft:tick",
                "conditions": {
                    "player": {
                        "type": "minecraft:entity_scores",
                        "entity": "this",
                        "scores": {
                            "cosmetic.runner_skin.bumblebee.hurt_timer": {
                                "min": 1
                            }
                        }
                    }
                }
            }
        },
        "rewards": {
            "function": (~/)
        }
    }

    advancement revoke @s only ~/

    scoreboard players remove @s cosmetic.runner_skin.bumblebee.hurt_timer 1
    execute if score @s cosmetic.runner_skin.bumblebee.hurt_timer matches 0 run return run function ./reset_anger:
        item modify entity @s armor.head {type:"minecraft:set_components",components:{"minecraft:profile":{texture:"hide_and_squeak:entity/player/cosmetic/runner_skin/bumblebee/head"}}}
        item modify entity @n[tag=hiding_form] contents {type:"minecraft:set_components",components:{"minecraft:profile":{texture:"hide_and_squeak:entity/player/cosmetic/runner_skin/bumblebee/hiding"}}}
        scoreboard players reset @s cosmetic.runner_skin.bumblebee.hurt_timer
        stopsound @a[tag=game.viewing] player minecraft:entity.bee.loop_aggressive

    item modify entity @s armor.head {type:"minecraft:set_components",components:{"minecraft:profile":{texture:"hide_and_squeak:entity/player/cosmetic/runner_skin/bumblebee/head_angry"}}}
    item modify entity @n[tag=hiding_form] contents {type:"minecraft:set_components",components:{"minecraft:profile":{texture:"hide_and_squeak:entity/player/cosmetic/runner_skin/bumblebee/hiding_angry"}}}
    execute if predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:periodic_tick":20}} run playsound minecraft:entity.bee.loop_aggressive player @a[tag=game.viewing] ~ ~ ~ 0.05 2