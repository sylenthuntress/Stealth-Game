from bolt_expressions import Scoreboard

# Set variables
scoreboard objectives remove var.players
execute if score $gamestate gamestate.round_active matches 1 run function game:round/end # End current round if present
scoreboard players set $gamestate gamestate.game_active 0
scoreboard players reset $gamestate gamestate.ranked_players
bossbar set game:time/round_timer players
bossbar set game:time/endgame_timer players

# Reset player data
scoreboard players reset * game.player.in_game
scoreboard players reset * game.player.killer_queue
execute as @a run function lobby:join_lobby

# Broadcast ending message
tellraw @a {"text":"\n"}
tellraw @a {"translate":"game.end","color":"gray","bold":false,"with": [{"translate":"main.game_name","color":"gold","bold":true}]}
execute function game:rankings/broadcast_winner:
    scoreboard players reset $highscore game.player.points
    execute as @a run scoreboard players operation $highscore game.player.points > @s game.player.points
    execute as @a if score @s game.player.points = $highscore game.player.points run tag @s add game.winner

    scoreboard objectives add var.points_decimal dummy
    scoreboard objectives add var.points_whole dummy

    points = Scoreboard("game.player.points")
    pointsDecimal = Scoreboard("var.points_decimal")
    pointsWhole = Scoreboard("var.points_whole")

    pointsWhole["$var"] = points["$highscore"] / 10
    pointsDecimal["$var"] = points["$highscore"] % 10
    execute unless score $var pointsDecimal matches 0 run tellraw @a {"translate": "game.end.winners", "color": "gold", "with": [{"selector":"@a[tag=game.winner]"}, [{"score": { "name": "$var", "objective": "var.points_whole"}, "color": "red"}, ".", {"score": {"name": "$var", "objective": "var.points_decimal"}, "color": "red"}]]}
    execute if score $var pointsDecimal matches 0 run tellraw @a {"translate": "game.end.winners", "color": "gold", "with": [{"selector":"@a[tag=game.winner]"}, [{"score": { "name": "$var", "objective": "var.points_whole"}, "color": "red"}]]}
execute if entity @a[tag=!game.winner,scores={game.player.points=1..}] run function game:rankings/broadcast_all:
    scoreboard players reset $highscore game.player.points
    execute as @a[tag=!game.winner,scores={game.player.points=1..}] run scoreboard players operation $highscore game.player.points > @s game.player.points
    execute as @a[tag=!game.winner,scores={game.player.points=1..}] if score @s game.player.points = $highscore game.player.points run tag @s add this.selected

    scoreboard objectives add var.points_decimal dummy
    scoreboard objectives add var.points_whole dummy

    points = Scoreboard("game.player.points")
    pointsDecimal = Scoreboard("var.points_decimal")
    pointsWhole = Scoreboard("var.points_whole")

    pointsWhole["$var"] = points["$highscore"] / 10
    pointsDecimal["$var"] = points["$highscore"] % 10
    execute unless score $var pointsDecimal matches 0 run tellraw @a {"translate": "game.end.rankings", "color": "gold", "with": [{"selector":"@a[tag=this.selected]"}, [{"score": { "name": "$var", "objective": "var.points_whole"}, "color": "red"}, ".", {"score": {"name": "$var", "objective": "var.points_decimal"}, "color": "red"}]]}
    execute if score $var pointsDecimal matches 0 run tellraw @a {"translate": "game.end.rankings", "color": "gold", "with": [{"selector":"@a[tag=this.selected]"}, {"score": { "name": "$var", "objective": "var.points_whole"}, "color": "red"}]}
    
    scoreboard players reset @a[tag=this.selected] game.player.points
    tag @a remove this.selected
    execute if entity @a[tag=!game.winner,scores={game.player.points=1..}] run function ~/
    del points
tellraw @a {"text":"=======================","color":"gold","bold":true}
scoreboard objectives setdisplay sidebar.team.gray
scoreboard objectives setdisplay sidebar.team.gold
scoreboard objectives setdisplay sidebar.team.dark_gray
scoreboard players reset * game.player.points
tag @a remove game.winner