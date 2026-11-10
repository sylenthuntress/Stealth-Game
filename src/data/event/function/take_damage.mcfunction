advancement ~/: {
  "criteria": {
    "condition": {
      "trigger": "minecraft:entity_hurt_player",
      "conditions": {}
    }
  },
  "rewards": {
    "function": (~/)
  }
}

advancement revoke @s only ~/

# Add tag to attack target
execute on attacker run tag @s add event.attacker

# Add context params
data remove storage event:data context.attacker
execute store success storage event:data context.attacker.is_player byte 1 if entity @p[tag=event.attacker]
execute store result storage event:data context.attacker.team_id int 1 run scoreboard players get @n[tag=event.attacker] game.player.team_id
execute store result storage event:data context.attacker.team_id int 1 run scoreboard players get @n[tag=event.attacker] game.player.team_id

execute at @s run function #~/ # Fire listeners
tag @e remove event.attacker