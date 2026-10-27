from bolt_expressions import Scoreboard, Data

damage_taken = Scoreboard("data.damage_taken")
total_damage = Scoreboard("game.player.damage")
prev_damage = Scoreboard("game.player.prev_damage")
injuries = Scoreboard("game.player.injury")
kill_threshold = Scoreboard("game.player.kill_threshold")

# Deduct player's health based on taken damage
total_damage["@s"] += damage_taken["@s"]
execute if score #gamestate gamestate.runners matches 2..:
    injuries["@s"] += damage_taken["@s"]
min(total_damage["@s"], kill_threshold["@s"])

# Display health percentage
percentage = Scoreboard("math.percentage")
percentage["#math.percentage"] = 100 - ((total_damage["@s"] * 100) / kill_threshold["@s"])

data merge storage var:injury {"title":{"color":"gray","translate":"", "with": [[{"text": "","color":"red","bold":true}],[{"score": {"name":"#math", "objective":"math.percentage"},"color":"gray","bold":true},{"text":"%"}]]}}
damage_text = Data.storage("var:injury")
damage_text["var:injury"]."title.with[0][0].text" = damage_taken["@s"]
data modify storage var:injury title.with[0][0].text set string storage var:injury title.with[0][0].text 0 -1

execute if score #math f"math.percentage" matches 66.. run data modify storage var:injury title.translate set value "gameplay.player.take_damage.low" 
execute if score #math f"math.percentage" matches 66.. run data modify storage var:injury title.with[1][0].color set value "green" 
execute if score #math f"math.percentage" matches 34..65 run data modify storage var:injury title.translate set value "gameplay.player.take_damage.med" 
execute if score #math f"math.percentage" matches 34..65 run data modify storage var:injury title.with[1][0].color set value "yellow" 
execute if score #math f"math.percentage" matches ..33 run data modify storage var:injury title.translate set value "gameplay.player.take_damage.high" 
execute if score #math f"math.percentage" matches ..33 run data modify storage var:injury title.with[1][0].color set value "red" 
function util:display_actionbar with storage var:injury

# Give points to attacker
points = Scoreboard("game.player.due_points")
points["#var"] = (total_damage["@s"] - prev_damage["@s"] + 5)/2
execute on attacker run tag @s add this.attacker
execute on attacker on origin run tag @s add this.attacker
execute unless entity @a[tag=this.attacker] as @a[scores={game.player.team_id=2}] run tag @s add this.attacker
execute as @a[tag=this.attacker] run function ./damage_credit:
    points["@s"] = points["#var"]
tag @a remove this.attacker

# Reveal attacker
execute on attacker expand:
    effect clear @s invisibility
    if score @s f"data.damage_dealt" matches 1.. run function game:gameplay/killer/land_hit

# Kill player at high damage
execute on attacker run tag @s add this.attacker
execute on attacker on origin run tag @s add this.attacker
if total_damage["@s"] >= kill_threshold["@s"] and prev_damage["@s"] > 1:
    execute if entity @a[tag=this.attacker] run function ./death
tag @a remove this.attacker

# Refresh health-based penalties
function game:gameplay/runner/update_injury
execute if entity @s[tag=hiding] run function game:gameplay/runner/stop_hiding

if damage_taken["@s"] >= 10: 
    execute function ./damage_boost:
        scoreboard players add @s time.player.damage_timer 45
        scoreboard players remove @s time.player.stun_timer 45
        attribute @s minecraft:movement_speed modifier add game:gameplay/runner/damaged 0.06 add_value