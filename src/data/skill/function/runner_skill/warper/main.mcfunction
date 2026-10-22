execute unless score @s skill.runner.warper.cooldown matches 100.. at @s run summon minecraft:marker ~ ~ ~ {Tags:["skill.runner.warper.warp_spot"]}
tag @s add this.self
execute as @e[type=marker,tag=skill.runner.warper.warp_spot] unless score @s uid.entity matches 0.. rotated as @a[tag=this.self,limit=1] run rotate @s ~ ~
execute as @e[type=marker,tag=skill.runner.warper.warp_spot] unless score @s uid.entity matches 0.. run scoreboard players operation @s uid.entity = @a[tag=this.self,limit=1] uid.player
execute as @e[type=marker,tag=skill.runner.warper.warp_spot] if score @s uid.entity = @a[tag=this.self,limit=1] uid.player run function ./tick_warp_spot:
    scoreboard players add @s skill.runner.warper.warp_spot 1
    execute if score @s skill.runner.warper.warp_spot matches 101.. run kill @s
tag @s remove this.self

execute if score @s skill.runner.warper.cooldown matches 1.. run function ./tick_cooldown:
    scoreboard players remove @s skill.runner.warper.cooldown 1

    scoreboard players operation #display time.display_sec = @s skill.runner.warper.cooldown
    scoreboard players operation #display time.display_sec /= #20 math.const

    item modify entity @s ./ability ./disable_ability
    item modify entity @s ./cooldown ./set_cooldown

    execute if score @s skill.runner.warper.cooldown matches 0 at @s run function ./end_cooldown:
        scoreboard players reset @s skill.runner.warper.cooldown
        item modify entity @s ./cooldown {
        "type": "minecraft:sequence",
        "functions": [
            {
                "type": "minecraft:set_item",
                "item": "minecraft:clock"
            },
            {
                "type": "minecraft:set_components",
                "components": {
                        "custom_name": {
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
                        "consumable": {
                            "consume_seconds": 0.05,
                            "has_consume_particles": false,
                            "animation": "bow",
                            "sound": {
                                "sound_id": ""
                            }
                        },
                        "custom_data": {
                            "skill.runner.warper.ability": true
                        },
                        "item_model": "hide_and_squeak:warp"
                    }
                }
            ]
        }
        playsound minecraft:block.end_portal_frame.fill player @s ~ ~ ~ 1 1