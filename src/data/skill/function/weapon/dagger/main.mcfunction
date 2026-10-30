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
                "skill.weapon.dagger"
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

execute if score @s time.player.recovery_timer matches 53.. run scoreboard players set @s time.player.recovery_timer 20