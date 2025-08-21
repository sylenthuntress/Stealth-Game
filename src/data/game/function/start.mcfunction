# Set variables
scoreboard players set $gamestate gamestate.game_active 1
scoreboard players reset $gamestate gamestate.round_count

# Start round
function game:round/start