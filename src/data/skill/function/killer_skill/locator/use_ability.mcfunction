advancement ./use_ability: {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:consume_item",
            "conditions": {
                "item": {
                    "predicates": {
                        "minecraft:custom_data": "{skill.killer.locator.ability: true, skill.killer.locator.locked: false}"
                    }
                }
            }
        }
    },
    "rewards": {
        "function": (./use_ability)
    }
}

advancement revoke @s only ./use_ability

item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:compass","predicates":{"minecraft:custom_data":{"skill.killer.locator.ability":true}}}} {
    "type": "minecraft:set_components",
        "components": {
            "!consumable": {},
            "custom_data": {
                "skill.killer.locator.ability": true,
                "skill.killer.locator.locked": true
            },
            "enchantment_glint_override": true
        }
    }

scoreboard players set @s skill.killer.locator.cooldown 400
scoreboard players set @s skill.killer.locator.tracking_timer 300

execute unless entity @a[distance=12..48,sort=furthest,team=runner] run return run function ./fail_ability:
    scoreboard players set @s skill.killer.locator.cooldown 1
    scoreboard players set @s skill.killer.locator.tracking_timer 1

    title @s actionbar {"color":"#9e3f3f","translate":"skill.killer.locator.fail_ability"}
    playsound minecraft:item.lodestone_compass.lock master @s ~ ~ ~ 1 0.2
    playsound minecraft:block.note_block.didgeridoo player @s ~ ~ ~ 0.5 1

scoreboard players operation @s skill.killer.locator.tracking_uid = @p[distance=12..48,sort=furthest,team=runner] uid.player
tag @s add this.self
execute as @a[team=runner] if score @s uid.player = @p[tag=this.self] skill.killer.locator.tracking_uid at @s expand:
    playsound minecraft:item.lodestone_compass.lock master @s ~ ~ ~ 2 1
    playsound minecraft:entity.evoker.prepare_attack master @s ~ ~ ~ 0.5 2
    tellraw @s {"color":"#C68346","translate":"skill.killer.locator.notification","with":[{"selector":"@a[tag=this.self]"}]}
tag @s remove this.self

title @s actionbar {"color":"#C68346","translate":"skill.killer.locator.use_ability"}
playsound minecraft:item.lodestone_compass.lock master @s ~ ~ ~ 2 1
playsound minecraft:entity.evoker.prepare_attack master @s ~ ~ ~ 0.5 2