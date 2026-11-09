advancement ~/: {
  "criteria": {
    "condition": {
      "trigger": "minecraft:tick",
      "conditions": {
        "player": {
          "type": "minecraft:entity_properties",
          "entity": "this",
          "predicate": {
            "minecraft:type_specific/player": {
              "input": {
                "jump": true
              }
            },
            "minecraft:movement": {
              "fall_distance": 0
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

execute at @s run function #~/