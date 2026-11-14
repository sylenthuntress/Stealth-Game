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
                "skill.weapon.auto_crossbow"
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

execute as @e[type=arrow,tag=skill.weapon.auto_crossbow.projectile,nbt={inGround:1b}] expand:
    execute on origin run function ./land_arrow:
        playsound minecraft:entity.arrow.hit master @s ~ ~ ~ 1 2 0.1
    kill @s

execute if score @s skill.weapon.auto_crossbow.count <= #gamestate gamestate.runners run function ./tick_cooldown:
    scoreboard players remove @s skill.weapon.auto_crossbow.cooldown 1
    execute if score @s skill.weapon.auto_crossbow.cooldown matches ..0 at @s run function ./end_cooldown:
        scoreboard players set @s skill.weapon.auto_crossbow.cooldown 200
        function ./give_item
        playsound minecraft:item.crossbow.quick_charge_1 master @s ~ ~ ~ 1 0.8