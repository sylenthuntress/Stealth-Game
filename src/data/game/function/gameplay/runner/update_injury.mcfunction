scoreboard players operation $math game.player.injury = @s game.player.injury
scoreboard players operation $math game.player.injury *= $100 math.const
scoreboard players operation $math game.player.injury /= @s game.player.kill_threshold

execute store result storage var:injury injury double -0.008 run scoreboard players get $math game.player.injury
function game:gameplay/movement_penalty/injury with storage var:injury