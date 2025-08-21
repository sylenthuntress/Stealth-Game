# Set variables
scoreboard players set $gamestate gamestate.game_active 1
scoreboard players reset $gamestate gamestate.round_count
scoreboard objectives setdisplay sidebar game.player.points # Add points board to sidebar

# Start round
function game:round/start