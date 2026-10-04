# Deduct player's health based on taken damage
scoreboard players operation @s game.player.damage += @s data.player.damage_taken
scoreboard players operation @s game.player.injury += @s data.player.damage_taken

# Apply movement speed penalty
execute store result storage var:damage damage double -0.001 run scoreboard players get @s game.player.damage
function game:gameplay/movement_penalty/injury with storage var:damage