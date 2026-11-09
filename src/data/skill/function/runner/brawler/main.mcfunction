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
                "skill.runner.brawler"
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

execute if score @s skill.runner.brawler.cooldown matches 1.. run function ./tick_cooldown:
    scoreboard players remove @s skill.runner.brawler.cooldown 1
    execute if score @s skill.runner.brawler.uses matches 3 expand:
        attribute @s minecraft:attack_damage modifier add ./cooldown -1 add_multiplied_base
        attribute @s minecraft:attack_speed modifier add ./cooldown -1 add_multiplied_base
        execute at @a[scores={game.player.team_id=2}] run particle crit ~ ~1 ~ 0.3 0.6 0.3 0 1 force @s
    
execute if score @s skill.runner.brawler.cooldown matches 0 run function ./end_cooldown:
    scoreboard players reset @s skill.runner.brawler.uses
    scoreboard players reset @s skill.runner.brawler.cooldown
    attribute @s minecraft:attack_damage modifier remove ./cooldown
    attribute @s minecraft:attack_speed modifier remove ./cooldown
    at @s run playsound minecraft:entity.vindicator.celebrate player @s ~ ~ ~ 0.1 2