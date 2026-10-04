# Deduct player's health based on taken damage
scoreboard players operation @s game.player.damage += @s data.player.damage_taken
scoreboard players operation @s game.player.injury += @s data.player.damage_taken

# Kill player at high damage
execute if score @s game.player.damage matches 200.. run function game:gameplay/death

# Refresh health-based penalties
function game:gameplay/update_health