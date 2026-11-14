append function_tag cosmetic:effects/take_damage {
    "values": [(~/)]
}

execute unless entity @s[tag=cosmetic.runner_skin.cave_turkey] run return fail

playsound minecraft:entity.chicken_picky.hurt player @a[tag=game.viewing] ~ ~ ~ 0.5 0.8

scoreboard players add @s cosmetic.runner_skin.cave_turkey.hurt_timer 100
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
                            "cosmetic.runner_skin.cave_turkey.hurt_timer": {
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

    scoreboard players remove @s cosmetic.runner_skin.cave_turkey.hurt_timer 1
        execute if predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:periodic_tick":10}} run playsound minecraft:entity.chicken_picky.ambient player @a[tag=game.viewing] ~ ~ ~ 0.5 0.8