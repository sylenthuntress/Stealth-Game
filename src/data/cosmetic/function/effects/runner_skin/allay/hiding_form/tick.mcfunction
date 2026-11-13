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
                "cosmetic.runner_skin.allay"
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

predicate ./is_moving: {
  "type": "minecraft:entity_properties",
  "entity": "this",
  "predicate": {
    "minecraft:movement": {
      "horizontal_speed": {
        "min": 0.1
      }
    }
  }
}

advancement revoke @s only ~/

tag @s add this.self
execute as @e[type=item_display,tag=hiding_form] if score @s uid.entity = @p[tag=this.self] uid.player run tag @s add this.display

execute if predicate ./is_moving as @n[type=item_display,tag=this.display] run function ./anim/move:
    function animation:cosmetic/runner_skin/allay/hiding_form/animations/idle/pause
    function animation:cosmetic/runner_skin/allay/hiding_form/animations/move/resume
execute unless predicate ./is_moving as @n[type=item_display,tag=this.display] run function ./anim/idle:
    function animation:cosmetic/runner_skin/allay/hiding_form/animations/move/pause
    function animation:cosmetic/runner_skin/allay/hiding_form/animations/idle/resume

tag @e remove this.display
tag @s remove this.self