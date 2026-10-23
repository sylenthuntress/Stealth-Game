execute if score #gamestate gamestate.round_active matches 1 unless score @s game.player.in_round matches 1 run function game:round/leave_round
execute if score #gamestate gamestate.game_active matches 1 unless score @s game.player.in_game matches 1 run function lobby:join_lobby

tag @s remove game.winner