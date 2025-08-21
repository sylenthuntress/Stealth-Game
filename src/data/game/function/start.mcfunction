# Set variables
scoreboard players set #GAMESTATE gamestate.game_active 1
scoreboard players reset #GAMESTATE gamestate.round_count

# Start round
function game:round/start