# End any active rounds
execute if score $gamestate gamestate.round_active matches 1 run function game:round/end

# Set variables
scoreboard players set $gamestate gamestate.game_active 0

# Reset player tags
tag @a remove playing
tag @a remove seeker_blacklist

# Broadcast ending message
tellraw @a {translate:"game.end"}