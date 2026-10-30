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
                "skill.weapon.foreseer"
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

execute unless slots entity @s {type:"minecraft:filtered",slot_source:{type:"minecraft:slot_range",slots:"weapon.mainhand"},item_filter:{items:"minecraft:bow"}} run scoreboard players reset @s skill.weapon.foreseer.charge_time

execute as @e[tag=skill.weapon.foreseer.spectral_bow.projectile,nbt={inGround:1b}] expand:
    at @s[type=spectral_arrow] run function skill:weapon/foreseer/land_arrow:
        playsound minecraft:entity.elder_guardian.curse master @a ~ ~ ~ 1 2
        execute on origin run playsound minecraft:entity.elder_guardian.curse master @s ~ ~ ~ 1 2 0.1

        execute positioned ~ ~-1 ~ as @a[tag=game.playing,team=runner,distance=..6] expand:
            effect give @s glowing 3 0 false
            effect give @s slowness 3 1 false

        particle firework ~ ~ ~ 0.1 0.1 0.1 0.25 10
    kill @s

execute if score @s skill.weapon.foreseer.cooldown matches 1.. run function skill:weapon/foreseer/tick_cooldown:
    scoreboard players remove @s skill.weapon.foreseer.cooldown 1

    scoreboard players operation #display time.display_sec = @s skill.weapon.foreseer.cooldown
    scoreboard players operation #display time.display_sec /= #20 math.const

    item modify entity @s skill:weapon/foreseer/spectral_arrow skill:weapon/foreseer/disable_arrow
    item modify entity @s skill:weapon/foreseer/cooldown skill:weapon/foreseer/set_cooldown
    item modify entity @s skill:weapon/foreseer/spectral_bow skill:weapon/foreseer/set_cooldown_bow

    execute if score @s skill.weapon.foreseer.cooldown matches 0 if slots entity @s skill:weapon/foreseer/cooldown at @s run function skill:weapon/foreseer/end_cooldown:
        scoreboard players reset @s skill.weapon.foreseer.cooldown
        item modify entity @s skill:weapon/foreseer/cooldown skill:weapon/foreseer/enable_arrow
        item modify entity @s skill:weapon/foreseer/spectral_bow skill:weapon/foreseer/reset_cooldown_bow
        playsound minecraft:item.crossbow.quick_charge_1 master @s ~ ~ ~ 1 0.8