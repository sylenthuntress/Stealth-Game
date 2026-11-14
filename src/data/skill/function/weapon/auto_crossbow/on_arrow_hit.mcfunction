projectile_tag = "skill.weapon.auto_crossbow.projectile"
advancement ~/: {
  "criteria": {
    "condition": {
      "trigger": "minecraft:player_hurt_entity",
      "conditions": {
        "damage": {
          "type": {
            "direct_entity": {
              "minecraft:entity_tags": {
                "any_of": [
                  projectile_tag
                ]
              }
            }
          }
        },
        "entity": {
          "type": "minecraft:entity_scores",
          "entity": "this",
          "scores": {
            "game.player.team_id": 1
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

execute unless entity @s[tag=skill.weapon.auto_crossbow] run return fail

function ./give_item