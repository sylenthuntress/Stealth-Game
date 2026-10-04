# Deduct player's health based on taken damage
scoreboard players operation @s game.player.damage += @s data.player.damage_taken
scoreboard players operation @s game.player.injury += @s data.player.damage_taken

# Refresh health-based penalties
function game:gameplay/update_health