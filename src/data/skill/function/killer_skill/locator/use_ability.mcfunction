advancement revoke @s only skill:killer_skill/locator/use_ability
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
execute at @s run scoreboard players operation @s skill.killer.locator.tracking_uid = @p[distance=..32,sort=furthest,team=runner] uid.player
tag @s add this.self
execute as @a[team=runner] if score @s uid.player = @p[tag=this.self] skill.killer.locator.tracking_uid at @s expand:
    playsound minecraft:item.lodestone_compass.lock master @s ~ ~ ~ 2 1
    playsound minecraft:entity.evoker.prepare_attack master @s ~ ~ ~ 0.5 2
    tellraw @s {"color":"#C68346","translate":"skill.killer.locator.notification","with":[{"selector":"@a[tag=this.self]"}]}
tag @s remove this.self

playsound minecraft:item.lodestone_compass.lock master @s ~ ~ ~ 2 1
playsound minecraft:entity.evoker.prepare_attack master @s ~ ~ ~ 0.5 2