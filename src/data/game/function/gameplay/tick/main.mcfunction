# Tick subtasks
function game:gameplay/tick/timer
execute as @a[scores={game.player.team_id=1},gamemode=adventure] at @s run function game:gameplay/tick/runners

# Apply due points
execute as @a[scores={game.player.due_points=1..}] run function game:add_points