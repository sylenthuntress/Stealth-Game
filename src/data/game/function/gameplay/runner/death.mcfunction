from bolt_expressions import Scoreboard

kill_threshold = Scoreboard("game.player.kill_threshold")
points = Scoreboard("game.player.due_points")

gamemode spectator
team join dead
scoreboard players reset @s skill.runner.medic.revive_uid
attribute @s minecraft:movement_speed modifier remove game:gameplay/runner/damaged

# Spawn corpse
execute function game:gameplay/runner/find_ground:
    execute positioned ~ ~-0.1 ~ if block ~ ~ ~ air run function game:gameplay/runner/find_ground
    execute unless block ~ ~-0.1 ~ air run function game:gameplay/runner/spawn_corpse with entity @s

# Give killer credit
points["#var"] = (kill_threshold["@s"]+5) / 2
execute on attacker run tag @s add this.killer
execute unless predicate {type:"minecraft:entity_properties",entity:"attacker",predicate:{}} run tag @a[scores={game.player.team_id=2}] add this.killer

execute as @a[tag=this.killer] function ./kill_credit:
    points["@s"] += points["#var"]
    function #skill:event/on_kill
points["@a[tag=!this.killer,scores={game.player.team_id=2}]"] + (points["#var"]+5) / 2
tag @e remove this.killer

# FX
playsound minecraft:entity.bat.death player @a ~ ~ ~ 1 2 0.1
tellraw @a[tag=game.viewing] {"translate": "gameplay.player.death_message", "color": "red", "bold": true, "with": [{"selector": "@s", "color": "dark_red", "bold": false}]}