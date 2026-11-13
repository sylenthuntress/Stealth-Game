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
    execute as @n[type=mannequin,tag=skill.runner.puppeteer.puppet] at @s run function ./start_hiding:
        data merge entity @s {pose:"crouching"}
        effect give @s invisibility infinite 0 true
        attribute @s minecraft:gravity modifier add game:gameplay/runner/hiding 0.02 add_value

        execute as @p[tag=this.selector] run function player:get/cosmetics
        summon minecraft:item_display ~ ~ ~ {Tags:["skill.runner.puppeteer.little_mouse","summoned"], teleport_duration: 1, item: {components: {"minecraft:profile": {properties: [{name: "textures", value: "eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZjM3OWUwOTI1MjgxNzMxNGJkMGI2OTRmN2Q1M2I0OGFmMmM3ZmE4NDk5MTA5ODAyYTQxYmIyOTRkMmY5M2UzZSJ9fX0="}]}}, count: 1, id: "minecraft:player_head"}, item_display: "head", start_interpolation: -1, transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [1.0f, 1.0f, 1.0f], translation: [0.0f, -0.5f, 0.0f]}}
        data modify entity @n[type=item_display,tag=skill.runner.puppeteer.little_mouse,tag=summoned] item set from storage player:data selected.cosmetics[{type:"cosmetic:runner/skin"}].components."cosmetic:hiding_form"
        execute as @n[type=item_display,tag=skill.runner.puppeteer.little_mouse,tag=summoned] expand: 
            scoreboard players operation @s uid.entity = @n[type=mannequin,tag=skill.runner.puppeteer.puppet] uid.entity
            execute rotated as @n[type=mannequin,tag=skill.runner.puppeteer.puppet] run rotate @s ~180 0
            ride @s mount @n[type=mannequin,tag=skill.runner.puppeteer.puppet]
            tag @s remove summoned
    kill @s

execute as @e[type=mannequin,tag=skill.runner.puppeteer.puppet] if score @s uid.entity = @p[tag=this.selector] uid.player run tag @s add this.selected

execute as @e[type=mannequin,tag=this.selected] at @s run function ./tick_puppet:
    execute on passengers run rotate @s ~180 0
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
            
            execute as @n[type=item_display,tag=skill.runner.puppeteer.little_mouse] if score @s uid.entity = @n[type=mannequin,tag=this.selected] uid.entity kill @s
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