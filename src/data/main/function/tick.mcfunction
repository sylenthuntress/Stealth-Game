# Tick subtasks
execute if score $gamestate gamestate.game_active matches 1 run function game:tick/main

# Handle new players
execute as @a unless score @s uid.player matches 0.. run function game:new_join