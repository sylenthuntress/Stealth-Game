import util:coordinates as coords
# Set variables
scoreboard players set $gamestate gamestate.game_active 1
scoreboard players reset $gamestate gamestate.round_count
scoreboard objectives setdisplay sidebar game.player.points # Add points board to sidebar

# Create new round
function game:round/new_round