advancement ~/: {
  "criteria": {
    "condition": {
      "trigger": "minecraft:player_hurt_entity",
      "conditions": {}
    }
  },
  "rewards": {
    "function": (~/)
  }
}

advancement revoke @s only ~/

# Add tag to attack target
tag @s add this.self
tag @e add this.candidate
execute as @e[tag=this.candidate] at @s run function ./internal/get_attack_target:
    tag @s remove this.candidate
    execute on attacker as @s[tag=this.self] expand:
        tag @n add event.attack_target
        tag @e remove this.candidate
tag @s remove this.self

# Add context params
data remove storage event:data context.attack_target
execute store success storage event:data context.attack_target.is_player byte 1 if entity @p[tag=event.attack_target]
execute store result storage event:data context.attack_target.team_id int 1 run scoreboard players get @n[tag=event.attack_target] game.player.team_id
execute store result storage event:data context.attack_target.team_id int 1 run scoreboard players get @n[tag=event.attack_target] game.player.team_id
execute store result storage event:data context.attack_target.damage_source.is_direct byte 1 if score @s data.damage_dealt matches 1..


execute at @s run function #~/ # Fire listeners
tag @e remove event.attack_target