scoreboard players operation @s game.player.due_points /= @s game.player.points_split

scoreboard players operation @s game.player.points += @s game.player.due_points
scoreboard players reset @s game.player.due_points