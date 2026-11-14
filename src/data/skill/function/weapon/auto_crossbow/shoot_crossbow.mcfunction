advancement ~/: {
  "criteria": {
    "condition": {
      "trigger": "minecraft:shot_crossbow",
      "conditions": {
        "item": {
          "predicates": {
            "minecraft:custom_data": {
              "skill.weapon.auto_crossbow": true
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

tag @n[type=arrow] add skill.weapon.auto_crossbow.projectile
execute as @n[type=arrow,tag=skill.weapon.auto_crossbow.projectile] run function ./set_motion:
    # Add tags
    tag @s add this.projectile
    execute on origin run tag @s add this.origin

    execute on origin rotated as @s positioned 0.0 0.0 0.0 positioned ^ ^ ^3 summon area_effect_cloud store success entity @s Duration int 1 run data modify entity @n[tag=this.projectile] Motion set from entity @s Pos

    # Add player motion to arrow
    execute as @p[tag=this.origin] expand:
        store result score @s skill.weapon.auto_crossbow.motion.x run data get entity @s Motion[0] 1000
        store result score @s skill.weapon.auto_crossbow.motion.y run data get entity @s Motion[1] 1000
        store result score @s skill.weapon.auto_crossbow.motion.z run data get entity @s Motion[2] 1000

    execute store result score @s skill.weapon.auto_crossbow.motion.x run data get entity @s Motion[0] 1000
    execute store result score @s skill.weapon.auto_crossbow.motion.y run data get entity @s Motion[1] 1000
    execute store result score @s skill.weapon.auto_crossbow.motion.z run data get entity @s Motion[2] 1000

    scoreboard players operation @s skill.weapon.auto_crossbow.motion.x += @p[tag=this.origin] skill.weapon.auto_crossbow.motion.x
    scoreboard players operation @s skill.weapon.auto_crossbow.motion.y += @p[tag=this.origin] skill.weapon.auto_crossbow.motion.y
    scoreboard players operation @s skill.weapon.auto_crossbow.motion.z += @p[tag=this.origin] skill.weapon.auto_crossbow.motion.z

    execute store result entity @s Motion[0] double 0.001 run scoreboard players get @s skill.weapon.auto_crossbow.motion.x
    execute store result entity @s Motion[1] double 0.001 run scoreboard players get @s skill.weapon.auto_crossbow.motion.y
    execute store result entity @s Motion[2] double 0.001 run scoreboard players get @s skill.weapon.auto_crossbow.motion.z

    # Remove tags
    tag @s remove this.projectile
    tag @a remove this.origin

scoreboard players set @s skill.weapon.auto_crossbow.cooldown 200
scoreboard players remove @s skill.weapon.auto_crossbow.count 1

execute if score @s skill.weapon.auto_crossbow.count matches 1.. run item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:crossbow","predicates":{"minecraft:custom_data":{"skill.weapon.auto_crossbow":true}}}} {
  "type": "minecraft:set_components",
  "components": {
    "minecraft:charged_projectiles": [
      {
        "id": "minecraft:arrow"
      }
    ]
  }
}
execute if score @s skill.weapon.auto_crossbow.count matches 1.. run clear @s arrow 1
