# Deduct player's health based on taken damage
scoreboard players operation @s game.player.damage += @s data.player.damage_taken
execute if score #gamestate gamestate.runners matches 2.. run scoreboard players operation @s game.player.injury += @s data.player.damage_taken
execute if score @s game.player.damage > @s game.player.kill_threshold run scoreboard players operation @s game.player.damage = @s game.player.kill_threshold

# Display health percentage
scoreboard players operation #math game.player.damage = @s game.player.damage
scoreboard players operation #math game.player.kill_threshold = @s game.player.kill_threshold
scoreboard players operation #math game.player.damage *= #100 math.const
scoreboard players operation #math game.player.damage /= #math game.player.kill_threshold

scoreboard players set #math math.percentage 100
scoreboard players operation #math math.percentage -= #math game.player.damage

data merge storage var:injury {"title":{"color":"gray","translate":"", "with": [[{"text": "","color":"red","bold":true}],[{"score": {"name":"#math", "objective":"math.percentage"},"color":"gray","bold":true},{"text":"%"}]]}}
execute store result storage var:injury title.with[0][0].text float 0.1 run scoreboard players get @s data.player.damage_taken
data modify storage var:injury title.with[0][0].text set string storage var:injury title.with[0][0].text 0 -1

execute if score #math math.percentage matches 66.. run data modify storage var:injury title.translate set value "gameplay.player.take_damage.low" 
execute if score #math math.percentage matches 66.. run data modify storage var:injury title.with[1][0].color set value "green" 
execute if score #math math.percentage matches 34..65 run data modify storage var:injury title.translate set value "gameplay.player.take_damage.med" 
execute if score #math math.percentage matches 34..65 run data modify storage var:injury title.with[1][0].color set value "yellow" 
execute if score #math math.percentage matches ..33 run data modify storage var:injury title.translate set value "gameplay.player.take_damage.high" 
execute if score #math math.percentage matches ..33 run data modify storage var:injury title.with[1][0].color set value "red" 
function util:display_actionbar with storage var:injury

scoreboard players reset #math game.player.percentage
scoreboard players reset #math game.player.kill_threshold
scoreboard players reset #math game.player.damage

# Give points to attacker
scoreboard players operation #math game.player.due_points = @s game.player.damage
scoreboard players operation #math game.player.due_points -= @s game.player.prev_damage
scoreboard players operation #math game.player.due_points *= #10 math.const
scoreboard players add #math game.player.due_points 9
scoreboard players operation #math game.player.due_points /= #4 math.const
scoreboard players operation #math game.player.due_points /= #10 math.const

execute on attacker run scoreboard players operation @s game.player.due_points += #math game.player.due_points
execute unless predicate {type:"minecraft:entity_properties",entity:"attacker",predicate:{}} as @a[scores={game.player.team_id=2}] run scoreboard players operation @s game.player.due_points += #math game.player.due_points
scoreboard players reset #math game.player.due_points
scoreboard players reset #math game.player.damage

# Reveal attacker
execute on attacker expand:
    effect clear @s invisibility
    if score @s data.player.damage_dealt matches 1.. run function game:gameplay/killer/land_hit

# Kill player at high damage
execute if score @s game.player.damage = @s game.player.kill_threshold if score @s game.player.prev_damage matches 1.. run function game:gameplay/runner/death

# Refresh health-based penalties
function game:gameplay/runner/update_injury
execute if entity @s[tag=hiding] run function game:gameplay/runner/stop_hiding

execute if score @s data.player.damage_taken matches 10.. expand:
    scoreboard players add @s time.player.damage_timer 45
    scoreboard players remove @s time.player.stun_timer 45
    attribute @s minecraft:movement_speed modifier add game:gameplay/runner/damaged 0.1 add_value