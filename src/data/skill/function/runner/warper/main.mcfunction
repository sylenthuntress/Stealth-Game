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
                "skill.runner.warper"
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
execute unless score @s skill.runner.warper.warp_length matches 1.. run return fail

summon minecraft:marker ~ ~ ~ {Tags:["skill.runner.warper.warp_spot","this.summoned"]}
scoreboard players operation @n[type=marker,tag=skill.runner.warper.warp_spot,tag=this.summoned] uid.entity = @s uid.player
execute rotated as @s run rotate @n[type=marker,tag=this.summoned] ~ ~
tag @n[type=marker,tag=this.summoned] remove this.summoned

tag @s add this.self
execute as @e[type=marker,tag=skill.runner.warper.warp_spot] if score @s uid.entity = @a[tag=this.self,limit=1] uid.player run function ./tick_warp_spot:
    scoreboard players add @s skill.runner.warper.warp_spot 1
    execute if score @s skill.runner.warper.warp_spot > @p[tag=this.self] skill.runner.warper.warp_length run kill @s
tag @s remove this.self