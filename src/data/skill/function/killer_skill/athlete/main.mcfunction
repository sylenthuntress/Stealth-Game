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
                "skill.killer.athlete"
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

scoreboard players remove @s[tag=skill.killer_skill.athlete.dashing] skill.killer.athlete.dash_timer 1
scoreboard players remove @s[tag=skill.killer_skill.athlete.dashing] time.player.stun_timer 1
execute if score @s skill.killer.athlete.cooldown matches 1.. run function ~/_cooldown:
    scoreboard players remove @s skill.killer.athlete.cooldown 1

    scoreboard players operation #display time.display_sec = @s skill.killer.athlete.cooldown
    scoreboard players operation #display time.display_sec /= #20 math.const

    item modify entity @s ./cooldown ./set_cooldown

    execute if score @s skill.killer.athlete.cooldown matches 0 run function ./end_cooldown:
        scoreboard players reset @s skill.killer.athlete.cooldown
        item modify entity @s ./cooldown ./enable_ability

execute if score @s skill.killer.athlete.dash_timer matches 1.. run function ./start_dashing:
    tag @s add skill.killer_skill.athlete.dashing
    attribute @s minecraft:movement_speed modifier add game:killer_skill/athlete/dashing 1.8 add_multiplied_base
    attribute @s minecraft:friction_modifier modifier add game:killer_skill/athlete/dashing -1 add_multiplied_base
    attribute @s minecraft:step_height modifier add game:killer_skill/athlete/dashing 1 add_value

execute if score @s skill.killer.athlete.dash_timer matches 0 run function ./stop_dashing:
    scoreboard players reset @s skill.killer.athlete.dash_timer
    tag @s remove skill.killer_skill.athlete.dashing
    attribute @s minecraft:movement_speed modifier remove game:killer_skill/athlete/dashing
    attribute @s minecraft:friction_modifier modifier remove game:killer_skill/athlete/dashing
    attribute @s minecraft:step_height modifier remove game:killer_skill/athlete/dashing