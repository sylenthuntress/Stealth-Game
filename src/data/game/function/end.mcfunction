from bolt_expressions import Scoreboard

# Set variables
scoreboard objectives remove var.players
execute if score $gamestate gamestate.round_active matches 1 run function game:round/end # End current round if present
scoreboard players set $gamestate gamestate.game_active 0
bossbar set game:time/round_timer players

# Reset player data
tag @a remove playing
tag @a remove killer_blacklist
execute as @a run function lobby:join_lobby

# Broadcast ending message
tellraw @a {translate:"game.end"}
execute function game:rankings/broadcast_winner:
    scoreboard players reset $highscore game.player.points
    execute as @a run scoreboard players operation $highscore game.player.points > @s game.player.points
    execute as @a if score @s game.player.points = $highscore game.player.points run tag @s add winner

    scoreboard objectives add var.points_decimal dummy
    scoreboard objectives add var.points_whole dummy

    points = Scoreboard("game.player.points")
    pointsDecimal = Scoreboard("var.points_decimal")
    pointsWhole = Scoreboard("var.points_whole")

    pointsWhole["$var"] = points["$highscore"] / 10
    pointsDecimal["$var"] = points["$highscore"] % 10
    tellraw @a {"translate": "game.end.winners", "color": "gold", "with": [{"selector":"@a[tag=winner]"}, [{"score": { "name": "$var", "objective": "var.points_whole"}, "color": "red"}, ".", {"score": {"name": "$var", "objective": "var.points_decimal"}, "color": "red"}]]}
execute function game:rankings/broadcast_all:
    scoreboard players reset $highscore game.player.points
    execute as @a[tag=!winner] run scoreboard players operation $highscore game.player.points > @s game.player.points
    execute as @a[tag=!winner] if score @s game.player.points = $highscore game.player.points run tag @s add selected

    scoreboard objectives add var.points_decimal dummy
    scoreboard objectives add var.points_whole dummy

    points = Scoreboard("game.player.points")
    pointsDecimal = Scoreboard("var.points_decimal")
    pointsWhole = Scoreboard("var.points_whole")

    pointsWhole["$var"] = points["$highscore"] / 10
    pointsDecimal["$var"] = points["$highscore"] % 10
    execute unless score $var pointsDecimal matches 0 run tellraw @a {"translate": "game.end.rankings", "color": "gold", "with": [{"selector":"@a[tag=selected]"}, [{"score": { "name": "$var", "objective": "var.points_whole"}, "color": "red"}, ".", {"score": {"name": "$var", "objective": "var.points_decimal"}, "color": "red"}]]}
    execute if score $var pointsDecimal matches 0 run tellraw @a {"translate": "game.end.rankings", "color": "gold", "with": [{"selector":"@a[tag=selected]"}, {"score": { "name": "$var", "objective": "var.points_whole"}, "color": "red"}]}
    
    scoreboard players reset @a[tag=selected] game.player.points
    tag @a remove selected
    execute if entity @a[tag=!winner,scores={game.player.points=1..}] run function game:rankings/broadcast_all
scoreboard objectives setdisplay sidebar
scoreboard players reset * points
tag @a remove winner