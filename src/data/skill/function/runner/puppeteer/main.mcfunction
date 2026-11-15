advancement ~/ {
  "criteria": {
    "requirement": {
      "trigger": "minecraft:tick",
      "conditions": {
        "player": {
          "type": "minecraft:entity_properties",
          "entity": "this",
          "predicate": {
            "minecraft:entity_tags": {
              "any_of": [
                "skill.runner.puppeteer"
              ]
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

tag @s add this.selector
execute as @e[type=marker,tag=skill.runner.puppeteer.puppet] at @s run function ./tick_snowball:
    particle minecraft:block_crumble{block_state:"minecraft:white_wool"} ~ ~ ~ 0.1 0.1 0.1 0.1 3 force @a[team=runner]

execute as @e[type=marker,tag=skill.runner.puppeteer.large_puppet] at @s unless predicate {type:"minecraft:entity_properties",entity:"this",predicate:{vehicle:{}}} run function ./land_large_puppet:
    function ./spawn_mannequin with entity @p[tag=this.selector]
    execute as @p[tag=this.selector] run function player:get/cosmetics
    data modify storage cosmetic:temp Recursive append from storage player:data selected.cosmetics[{"type": "cosmetic:runner/skin"}].components."cosmetic:equipment"[]
    execute as @n[type=mannequin,tag=skill.runner.puppeteer.puppet] run function ./set_armor with storage cosmetic:temp Recursive[0]
    function ./set_armor:
        $item replace entity @s weapon.mainhand with $(id) 1
        $item modify entity @s weapon.mainhand {type:"minecraft:set_components",components:$(components)}
        $item replace entity @s $(slot) from entity @s weapon.mainhand
        item replace entity @s weapon.mainhand with air

        data remove storage cosmetic:temp Recursive[0]
        execute if data storage cosmetic:temp Recursive[0] run function ~/ with storage cosmetic:temp Recursive[0]
    tag @n[type=mannequin,tag=skill.runner.puppeteer.puppet] add skill.runner.puppeteer.large_puppet
    kill @s

execute as @e[type=marker,tag=skill.runner.puppeteer.small_puppet] at @s unless predicate {type:"minecraft:entity_properties",entity:"this",predicate:{vehicle:{}}} run function ./land_small_puppet:
    function ./spawn_mannequin with entity @p[tag=this.selector]
    item fill entity @n[type=mannequin,tag=skill.runner.puppeteer.puppet] armor.body from entity @p[tag=this.selector] armor.body
    tag @n[type=mannequin,tag=skill.runner.puppeteer.puppet] add skill.runner.puppeteer.small_puppet
    tag @n[type=mannequin,tag=skill.runner.puppeteer.puppet] add hiding
    execute as @n[type=mannequin,tag=skill.runner.puppeteer.puppet] at @s rotated as @s run function ./start_hiding:
        execute unless score @s uid.hiding_form matches 0.. store result score @s uid.hiding_form run scoreboard players add #uid.index uid.hiding_form 1 
        data merge entity @s {pose:"crouching"}
        effect give @s invisibility infinite 0 true
        attribute @s minecraft:gravity modifier add game:gameplay/runner/hiding 0.02 add_value

        execute as @p[tag=this.selector] run function cosmetic:effects/hiding_form
        tag @n[tag=hiding_form] add skill.runner.puppeteer.hiding_form
        scoreboard players operation @n[tag=skill.runner.puppeteer.hiding_form] uid.hiding_form = @s uid.hiding_form
    kill @s

execute as @e[type=mannequin,tag=skill.runner.puppeteer.puppet] if score @s uid = @p[tag=this.selector] uid run tag @s add this.selected

execute as @e[type=mannequin,tag=this.selected] at @s run function ./tick_puppet:
    function #./fake_cosmetic
    execute as @s[tag=skill.runner.puppeteer.small_puppet] anchored feet unless entity @e[tag=skill.runner.puppeteer.hiding_form,distance=..0.125] run function ./tick_hiding:
        execute as @e[tag=skill.runner.puppeteer.hiding_form] if score @s uid.hiding_form = @n[tag=this.selected] uid.hiding_form run tag @s add this.display
        execute as @n[tag=this.display,distance=0.125..] expand:
            at @s positioned ~-1.125 ~-1 ~-1.125 unless entity @n[tag=this.selected,dx=0.25,dz=0.25] run rotate @s facing entity @n[tag=this.selected] eyes
            at @s run rotate @s ~ 0
            tp @s ~ ~ ~

        execute if predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:effects":{"minecraft:glowing":{}}}} run function ./glow_hiding:
            execute store result score #var time.entity.glow_timer run data get entity @s active_effects[{id:"minecraft:glowing"}].duration
            scoreboard players operation @n[tag=this.display] time.entity.glow_timer += #var time.entity.glow_timer
            scoreboard players reset #var time.entity.glow_timer
            data merge entity @n[tag=this.display] {Glowing:1b}
            effect clear @s minecraft:glowing
        scoreboard players remove @n[tag=this.display,scores={time.entity.glow_timer=1..}] time.entity.glow_timer 1
        execute as @n[tag=this.display] if score @s time.entity.glow_timer matches ..0 expand:
            data merge entity @s {Glowing:0b}
            scoreboard players reset @s time.entity.glow_timer

        tag @e remove this.display

    store result score @s skill.runner.puppeteer.puppet.curr_hp run data get entity @s Health
    on attacker run tag @s add this.attacker
    if score @s skill.runner.puppeteer.puppet.curr_hp < @s skill.runner.puppeteer.puppet.prev_hp expand:
        if entity @a[tag=this.attacker,team=runner] rotated as @a[tag=this.attacker] run rotate @s ~ 0
        if entity @a[tag=this.attacker,team=killer] run function ./damage_mannequin:
            scoreboard players add @p[tag=this.selector] game.player.due_points 15
            execute if entity @s[tag=skill.runner.puppeteer.large_puppet] run scoreboard players add @p[tag=this.selector] game.player.due_points 15

            execute on attacker at @s expand:
                scoreboard players add @s time.player.stun_timer 80
                execute if entity @n[tag=this.selected,tag=skill.runner.puppeteer.large_puppet] run scoreboard players add @s time.player.stun_timer 60

                execute if entity @n[tag=this.selected,tag=skill.runner.puppeteer.small_puppet] run effect give @s darkness 4 0 false
                execute if entity @n[tag=this.selected,tag=skill.runner.puppeteer.large_puppet] run effect give @s blindness 7 0 false

                execute if entity @n[tag=this.selected,tag=skill.runner.puppeteer.small_puppet] run tellraw @a[tag=game.viewing] {"translate":"skill.runner.puppeteer.small_puppet.announce","color":"#caa541","with":[{"selector":"@s"}]}
                execute if entity @n[tag=this.selected,tag=skill.runner.puppeteer.large_puppet] run tellraw @a[tag=game.viewing] {"translate":"skill.runner.puppeteer.large_puppet.announce","color":"#caa541","with":[{"selector":"@s"}]}
                playsound minecraft:block.netherite_block.break master @a[tag=game.viewing] ~ ~ ~ 1000 0.5
                playsound minecraft:block.netherite_block.break master @a[tag=game.viewing] ~ ~ ~ 1000 0.67
                playsound minecraft:block.netherite_block.break master @a[tag=game.viewing] ~ ~ ~ 1000 0.75
            
            execute as @e[tag=skill.runner.puppeteer.hiding_form] if score @s uid.hiding_form = @n[type=mannequin,tag=this.selected] uid.hiding_form on passengers run kill @s
            execute as @e[tag=skill.runner.puppeteer.hiding_form] if score @s uid.hiding_form = @n[type=mannequin,tag=this.selected] uid.hiding_form kill @s
            kill @s
            
    tag @a remove this.attacker
    scoreboard players operation @s skill.runner.puppeteer.puppet.prev_hp = @s skill.runner.puppeteer.puppet.curr_hp
    tag @s remove this.selected
tag @s remove this.selector

execute if score @s skill.runner.puppeteer.cooldown matches 1.. run function ~/tick_cooldown:
    scoreboard players remove @s skill.runner.puppeteer.cooldown 1

    scoreboard players operation #display time.display_sec = @s skill.runner.puppeteer.cooldown
    scoreboard players operation #display time.display_sec /= #20 math.const

    item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:barrier","predicates":{"minecraft:custom_data":{"skill.runner.puppeteer.cooldown":true}}}} {
            "type": "minecraft:set_name",
            "entity": "this",
            "name": [
                {
                    "sprite": "hide_and_squeak:item/small_puppet",
                    "atlas": "minecraft:items",
                    "color": "dark_gray"
                },
                " ",
                {
                    "color": "dark_gray",
                    "bold": true,
                    "italic": false,
                    "translate": "skill.cooldown",
                    "with": [
                        {
                            "score": {
                                "name": "#display",
                                "objective": "time.display_sec"
                            },
                            "bold": true,
                            "color": "#9e9d9b"
                        }
                    ]
                }
            ]
        }

    execute if score @s skill.runner.puppeteer.cooldown matches 0 at @s run function ./end_cooldown:
        scoreboard players reset @s skill.runner.puppeteer.cooldown
        item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:barrier","predicates":{"minecraft:custom_data":{"skill.runner.puppeteer.large_puppet":true,"skill.runner.puppeteer.cooldown":true}}}} {
            "type": "minecraft:sequence",
            "functions": [
                {
                    "type": "minecraft:set_item",
                    "item": "minecraft:player_head"
                },
                {
                    "type": "minecraft:set_components",
                    "components": {
                        "custom_name": {
                            "color": "#caa541",
                            "translate": "skill.runner.puppeteer.large_puppet",
                            "italic": false,
                            "with": [
                                {
                                    "sprite": "hide_and_squeak:item/small_puppet",
                                    "atlas": "minecraft:items",
                                    "color": "white"
                                },
                                [
                                    {
                                        "translate": "skill.use",
                                        "color": "gold"
                                    },
                                    {
                                        "text": "/",
                                        "color": "gold"
                                    },
                                    {
                                        "translate": "skill.drop",
                                        "color": "gold"
                                    }
                                ]
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
                            "skill.runner.puppeteer.ability": true,
                            "skill.runner.puppeteer.large_puppet": true,
                            "skill.runner.puppeteer.cooldown": false
                        },
                        "!minecraft:equippable":{},
                        "item_model":"hide_and_squeak:large_puppet"
                    }
                },
                {type:"minecraft:fill_player_head",entity:"this"}
            ]
        }
        item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:barrier","predicates":{"minecraft:custom_data":{"skill.runner.puppeteer.small_puppet":true,"skill.runner.puppeteer.cooldown":true}}}} {
            "type": "minecraft:sequence",
            "functions": [
                {
                    "type": "minecraft:set_item",
                    "item": "minecraft:copper_nugget"
                },
                {
                    "type": "minecraft:set_components",
                    "components": {
                        "custom_name": {
                            "color": "#caa541",
                            "translate": "skill.runner.puppeteer.small_puppet",
                            "italic": false,
                            "with": [
                                {
                                    "sprite": "hide_and_squeak:item/small_puppet",
                                    "atlas": "minecraft:items",
                                    "color": "white"
                                },
                                [
                                    {
                                        "translate": "skill.use",
                                        "color": "gold"
                                    },
                                    {
                                        "text": "/",
                                        "color": "gold"
                                    },
                                    {
                                        "translate": "skill.drop",
                                        "color": "gold"
                                    }
                                ]
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
                            "skill.runner.puppeteer.ability": true,
                            "skill.runner.puppeteer.small_puppet": true,
                            "skill.runner.puppeteer.cooldown": false
                        },
                        "item_model": "hide_and_squeak:small_puppet"
                    }
                }
            ]
        }