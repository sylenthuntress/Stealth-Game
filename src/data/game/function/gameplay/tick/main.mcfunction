# Tick subtasks
function game:gameplay/tick/timer

# Tick individual team-specific logic
execute as @a if function util:test/is_playing run function game:gameplay/tick/player:
    help