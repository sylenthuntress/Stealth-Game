# Tick subtasks
function game:gameplay/tick/timer
execute as @a[scores={game.player.team_id=1},gamemode=adventure] at @s run function game:gameplay/tick/sneaker_manager