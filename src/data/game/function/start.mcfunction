import util:coordinates as coords
# Set variables
scoreboard players set $gamestate gamestate.game_active 1
scoreboard players set $gamestate gamestate.generating 0
scoreboard players reset $gamestate gamestate.round_count
scoreboard objectives setdisplay sidebar game.player.points # Add points board to sidebar
scoreboard players set * game.player.points_mult 1

# Create new round
function game:round/new_round